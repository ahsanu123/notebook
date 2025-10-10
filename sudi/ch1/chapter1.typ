#import "@preview/lovelace:0.3.0": *
#import "@preview/chronos:0.2.1"
#import emoji: apple

#set heading(numbering: "1.1.")
#set figure(numbering: "Fig 1.1.")
#set math.equation(numbering: "Eq1.1.")
#set par(justify: true)

#let appleRed = apple.red

#let BLEServer = "BLE Server"

#let COR_MatrixDataReader = "Matrix Data Reader"
#let COR_LayerManager = "Layer Manager"
#let COR_KeyboardReportIssuer = "Keyboard Report Issuer"
#let COR_LEDController = "LED Controller"

#let IntervalIssuer_Main = "Interval Issuer"
#let IntervalIssuer_BatteryReader = "Battery Reader Task"
#let IntervalIssuer_BatteryCharging = "Battery Charging Task"

= Sudi Algorithm Collections

Contain documentation for algorithm method used in Sudi. Sudi will have 3 main Component 

- 🗄️ BLE Server\
  main gate to transfering data from keyboard to connected host

- 🔗 Chain Of Responsibilies (COR)\
  contain Event Handler, this can be _Led_Controller_ , _Keyboard_Report_Issuer_, _etc_, 
  every COR will check for _Event Type_, if COR able to handle that _Type_ it will run, 
  but if not, it will pass to next COR. COR literally just a function


- ⏳ Interval Issuer\
  Interval Issuer is main handler for sending interval task result to BLE Server, it receive data from signal

*🔗 Basic Sequence Diagram For COR*

#chronos.diagram({
  import chronos: *

  _par(COR_MatrixDataReader)
  _par(COR_LayerManager)
  _par(COR_KeyboardReportIssuer)
  _par(COR_LEDController)
  _par(BLEServer)

  _seq(COR_MatrixDataReader, COR_MatrixDataReader, comment: [Scan Switch\ Matrix])
  _seq(COR_MatrixDataReader, COR_LayerManager, comment: [Send Data To\ Layer Manager])
  _seq(COR_LayerManager, COR_KeyboardReportIssuer, comment: [Send\ *KeyCharEvent* ])
  _seq(COR_KeyboardReportIssuer, BLEServer, comment: [make keyboard\ report and send to \ *BLEServer* ])

  _seq(COR_LayerManager, COR_LEDController, comment: [Send\ *KeyCharEvent* ])
  _seq(COR_LEDController, COR_LEDController, comment: [Light On/Off\ based on\ event])
})

#pagebreak()

*⏳ Basic Sequence Diagram For Interval Issuer*
#chronos.diagram({
  import chronos: *

  _par(IntervalIssuer_BatteryReader)
  _par(IntervalIssuer_BatteryCharging )
  _par(IntervalIssuer_Main)
  _par(BLEServer)

  _loop("Battery Reader Loop",{
    _seq(IntervalIssuer_BatteryReader , IntervalIssuer_BatteryReader , comment: [Read Battery\ status for\ Every 30 seconds])

    _seq(IntervalIssuer_BatteryReader, IntervalIssuer_Main, comment: [Send Battery Data])
    _seq(IntervalIssuer_Main, BLEServer, comment: [Make Battery\ Report and\ send to \ *BLEServer*])
  })

  _loop("Battery Charging Loop",{
    _seq(IntervalIssuer_BatteryCharging , IntervalIssuer_BatteryCharging , comment: [Check if\ Battery in Charging\ Mode])

    _seq(IntervalIssuer_BatteryCharging , IntervalIssuer_Main, comment: [Send Charging Status])
    _seq(IntervalIssuer_Main, BLEServer, comment: [Make Battery\ Report and\ send to \ *BLEServer*])
  })
})

*Several Note*

- *transpose function reference*

```rs
fn transpose_fixed_size<const R: usize, const C: usize, T: Copy>(
    matrix: [[T; C]; R],
) -> [[T; R]; C] {
    let mut transposed = [[matrix[0][0]; R]; C]; 
    for r in 0..R {
        for c in 0..C {
            transposed[c][r] = matrix[r][c];
        }
    }
    transposed
}
```

- *Column to Row Schematic Example*

#image("../img/col_to_row_sch.png")

#pagebreak()

== Direct Switch Matrix Scan 

direct switch matrix scan mean, using GPIO directly to read what user type.

#pseudocode-list(title: [ #appleRed *Direct Switch Matrix Scan* (rust taste)], booktabs: true)[
  + enum *eDiodeDirection*
    + ROW2COL
    + COL2ROW
  + *end* enum
  + \
  + let COL_NUM: *int*
  + let ROW_NUM: *int*
  + let diodeDirction: *eDiodeDirection* 
  + let matrixResult: *[[bool; COL_NUM]; ROW_NUM]*
  + \
  + *if* diodeDirction == *ROW2COL*
    + *foreach* row in 0 .. *ROW_NUM* - 1
      + rowPins[row].setHigh()
      + let columnState = *read all column pin state*
      + matrixResult.push(columnState)
    + *end*
  + *end*
  + \
  + *else if* diodeDirction == *COL2ROW*
  + let tempMatrixResult: [[bool; ROW_NUM]; COL_NUM]
  + \
  + 
    + *foreach* col in 0 .. *COL_NUM* - 1
      + colPins[col].setHigh()
      + let rowState = *read all row pin state*
      + tempMatrixResult.push(rowState)
    + *end*
  + \ 
  + matrixResult = *tranpose*(tempMatrixResult)
  + *end*
  + \
  + *return* matrixResult
]

#pagebreak()
== Indirect Switch Matrix Scan 

Indirect switch matrix scanning mean, using another component to read what user type, 
for example for current Sudi implementation, we use MC23017 (I2C) for reading 
right side of keyboard.

#pseudocode-list(title: [#appleRed Indirect Switch Matrix Scan], booktabs: true)[
  + enum *eDiodeDirection*
    + ROW2COL
    + COL2ROW
  + *end* enum
  + \
  + let COL_NUM: *int*
  + let ROW_NUM: *int*
  + let diodeDirction: *eDiodeDirection* 
  + let matrixResult: *[[bool; COL_NUM]; ROW_NUM]*
  + \
  + *if* diodeDirction == *ROW2COL*
    + *foreach* row in 0 .. *ROW_NUM* - 1
      + *setPinAt*(row, HIGH)
      + let columnState = *read all column pin state*
      + matrixResult.push(columnState)
    + *end*
  + *end*
  + \
  + *else if* diodeDirction == *COL2ROW*
  + let tempMatrixResult: [[bool; ROW_NUM]; COL_NUM]
  + \
  + 
    + *foreach* col in 0 .. *COL_NUM* - 1
      + *setPinAt*(col, HIGH)
      + let rowState = *read all row pin state*
      + tempMatrixResult.push(rowState)
    + *end*
  + *end*
  + \ 
  + matrixResult = *tranpose*(tempMatrixResult)
  + *end*
  + \
  + *return* matrixResult
]

#pagebreak()
== MCP23017 Reading Function

#pseudocode-list(title: [#appleRed MCP23017 Reading], booktabs: true)[
  + *TODO*
]

#pagebreak()
== Raw Matrix Reading To KeyMap Function

This function will convert raw swtich matrix reading (array of array of type bool) into array of struct *KeyChar*, then we can use that further in out *COR* (Chain Of Responsibilies)

#pseudocode-list(title: [#appleRed Raw Matrix To Keymap], booktabs: true)[
  + struct *KeyChar*
    + character: *char*
    + row: *int*
    + col: *int*
  + *end*
  + \
  + let keyMaps = *COL_NUM \* ROW_NUM character map defined by user*
  + let rawMatrixData = *data from direct or indirect switch matrix reading*
  + let keyChars: [*KeyChar*; COL_NUM \* ROW_NUM]
  + \ 
  + 
  + *foreach* row, rowIndex *in* rawMatrixData 
    + *foreach* col, colIndex *in* row 
      + *if* col == *HIGH*
        + let char = *KeyChar {*
            + character = *keyMaps*[rowIndex][colIndex]
            + row = *rowIndex*
            + col = *colIndex*
          + *}*
        + keyChars.push(char)
      + *end*
    + *end*
  + *end*
  + \
  + *return* keyChars
]

#pagebreak()

== Chain Of Responsibilies (COR) 

COR is the main trait will use for Sudi, its like Middleware in API Backend Term.

#pseudocode-list(title: [#appleRed Raw Matrix To Keymap], booktabs: true)[
  + struct *KeyChar*
    + character: *char*
    + row: *int*
    + col: *int*
  + *end*
]

== LED Controller COR

#pseudocode-list(title: [#appleRed Raw Matrix To Keymap], booktabs: true)[
  + trait *Event*
    + *type* Data
  + *end*
  + \ 
  + 
  + struct 
    + 
  + end 
]

== Layer Manager COR

== Interval Issuer

== Interval Task
