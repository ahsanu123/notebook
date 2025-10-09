#import "@preview/chronos:0.2.1"

#set page(flipped: true)
#set heading(numbering: "1.1.")
#set figure(numbering: "Fig 1.1.")
#set math.equation(numbering: "Eq1.1.")
#set par(justify: true)

#let figWithImg(path, caption: "" ) = {
  figure(
    image(path), 
    caption: caption
  )
}

#let user = "User"
#let admin = "Admin"
#let mainPagestate= "Main Page State"
#let adminPageState = "Admin Page State"
#let takingPageState = "Taking Page State"
#let adminPage = "Admin Page"
#let API = "API"

= System Flow

description of all system flow

== User Taking Flow

#chronos.diagram({
  import chronos: *

  _par(user)
  _par(takingPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [default page\ dasboard (taking page)], pos: (user))

  _seq(user, takingPageState, comment: "Select Username")
  _seq(takingPageState, takingPageState, comment: "Display Keypad")
  _seq(user, takingPageState, comment: "Insert Taking Amount")
  _seq(takingPageState, mainPagestate, comment: "Set Last User")
  _seq(mainPagestate, API, comment: "Get Taking Data For Current Month")
  _note("over", [get data with user id], pos: (mainPagestate, API))

  _seq(API, mainPagestate, comment: "return user data")
  _seq(mainPagestate, mainPagestate, comment: "set user data")
  _note("over", [set to latest selected user],pos: (mainPagestate))

  _seq(mainPagestate, user, comment: "🗺️ redirect to dasboard")

})

== Admin Flow

Admin able to do CRUD operation to taking record, CRUD operation to User/Customer, and able to generate Bill or Payment Record.

=== Admin Taking Record CRUD

$"Password" = ("CurrentDate" - "CurrentMonth") * ("CurrentMonth" * "CurrentYear")$

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)

  _seq(admin, admin, comment: "click on secret button")
  _note("over", [secret button\ will show keypad\ for admin to login,\ look password equation above], pos: (admin))

  _loop("loop until password correct", {
    _seq(admin, adminPage, comment: "enter password")
    _seq(adminPage, adminPage, comment: "check if password correct")

    _alt("Password Wrong", {
        _seq(adminPage, admin , comment: "Re-enter Password")
      },
    )
  })

  _seq(adminPage, adminPageState, comment: "password correct")
  _seq(adminPageState, adminPageState, comment: "set admin mode to true")
  _seq(adminPageState, mainPagestate, comment: "set active user to admin")

  _seq(adminPageState, adminPage, comment: "display admin menu")
  _seq(adminPage, admin, comment: "give control back to admin")

  _note("over", [continue to next page], pos: (admin), color: blue)

})

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)

  // upsert taking record
  _note("over", [upsert taking record], pos: (admin))
  _seq(admin, admin, comment: [admin select\ customer from\ dropdown])
  _seq(admin, adminPageState, comment: [admin select date\ from calendar])
  _seq(adminPageState, adminPageState, comment: [set select taking\ record user id and date])
  _seq(adminPageState, admin, comment: [display overlay popup\ to edit current user taking])

  _seq(admin, admin, comment: [admin edit selected\ taking record data])
  _seq(admin, adminPage, comment: [admin click update\ or save button])
  _seq(adminPage, API, comment: [save to API\ and close overlay popup])
  _seq(API, API, comment: [Save to\ Database])
  _seq(API, admin, comment: [give control back to admin])

  _note("over", [continue to next page], pos: (admin), color: blue)

})

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)

  // delete taking record
  _note("over", [delete taking record], pos: (admin))

  _seq(admin, admin, comment: [admin select\ customer from\ dropdown])
  _seq(admin, adminPageState, comment: [admin select date\ from calendar])
  _seq(adminPageState, adminPageState, comment: [set select taking\ record user id and date])
  _seq(adminPageState, admin, comment: [display overlay popup\ to edit current user taking])

  _seq(admin, adminPage, comment: [admin select\ taking record\ to delete])

  _alt([If Taking\ Record is paid], {
      _gap()
      _seq(adminPage, admin , comment: [display message\ "unable to \ delete paid\ record"])
      _seq(adminPage, admin , comment: [close overlay\ popup])
    }
  )
  _note("over", [continue to next page], pos: (admin), color: blue)
})

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)

  _seq(adminPage, API, comment: [Delete Taking Record])

  _note("over", [delete by user id\ and date], pos: (API))
  
  _seq( API, admin, comment: [give control\ back to admin])
})
