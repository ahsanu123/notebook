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

#let customer = "Customer"
#let admin = "Admin"
#let mainPagestate= "Main Page State"
#let adminPageState = "Admin Page State"
#let paymentPageState = "Payment Page State"
#let takingPageState = "Taking Page State"
#let adminPage = "Admin Page"
#let paymentPage = "Payment Page"
#let API = "API"

= System Flow

description of all system flow

== User Taking Flow

#chronos.diagram({
  import chronos: *

  _par(customer)
  _par(takingPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [default page\ dasboard (taking page)], pos: (customer))

  _seq(customer, takingPageState, comment: "Select Username")
  _seq(takingPageState, takingPageState, comment: "Display Keypad")
  _seq(customer, takingPageState, comment: "Insert Taking Amount")
  _seq(takingPageState, mainPagestate, comment: "Set Last User")
  _seq(mainPagestate, API, comment: "Get Taking Data For Current Month")
  _note("over", [get data with user id], pos: (mainPagestate, API))

  _seq(API, mainPagestate, comment: "return user data")
  _seq(mainPagestate, mainPagestate, comment: "set user data")
  _note("over", [set to latest selected user],pos: (mainPagestate))

  _seq(mainPagestate, customer, comment: "🗺️ redirect to dasboard")

})

== Admin Flow

Admin able to do CRUD operation to taking record, CRUD operation to User/Customer, and able to generate Bill or Payment Record.

#set page(flipped: false)
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
  _note("over", [secret button\ will show keypad\ for admin to login,\ look password\ equation above], pos: (admin))

  _loop("loop until password correct", {
    _seq(admin, adminPage, comment: "enter password")
    _seq(adminPage, adminPage, comment: [check if\ password correct])

    _alt("Password Wrong", {
        _seq(adminPage, admin , comment: "Re-enter Password")
      },
    )
  })

  _seq(adminPage, adminPageState, comment: "password correct")
  _seq(adminPageState, adminPageState, comment: [set admin\ mode to true])
  _seq(adminPageState, mainPagestate, comment: [set active\ user to admin])

  _seq(adminPageState, adminPage, comment: "display admin menu")
  _seq(adminPage, admin, comment: "give control back to admin")

  _note("over", [continue to next page], pos: (admin), color: blue)

})

#set page(flipped: true)

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

#pagebreak()

=== Admin Dreg Price update 

there is 1 default price, admin able to update price but unable to delete, price will be use newest/latest updated price.

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [admin click\ dreg price button], pos: (admin))
  _seq(admin, adminPage, comment: [diplay edit\ dreg price component])
  _seq(admin, adminPage, comment: [admin enter\ new price])

  _alt([updated price is different],{
    _seq(adminPage, API, comment: [update dreg price ])
    _seq(API, API, comment: [save new dreg\ price to database ])
  })

  _seq( API, admin, comment: [give control\ back to admin])
  
})

=== Admin List All Dreg Price
// list all dreg price
#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(adminPage)
  _par(adminPageState)
  _par(mainPagestate)
  _par(API)
  _note("over", [admin click\ list dreg price button], pos: (admin))

  _seq(admin, adminPage, comment: [diplay list\ dreg price component])
  _seq(adminPage, API, comment: [get all dreg price])
  _seq(API, API, comment: [retrieve data from db])
  _seq(API, adminPage, comment: [return prices data])

  _seq( API, admin, comment: [give control\ back to admin])
})

#pagebreak()

#set page(flipped: false)
== Customer Payment

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(customer)
  _par(paymentPage)
  _par(paymentPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [admin enter\ payment page], pos: (admin))
  
  _seq(admin, paymentPage, comment: [admin select customer\ and choose month])
  _seq(admin, paymentPage, comment: [click make payment])
  _seq(paymentPage, paymentPage, comment: [display overlay\ popup for payment])

  _seq(admin, paymentPage, comment: [admin make\ payment operation])
  _seq(paymentPage, API, comment: [save payment operatin into db])
  _seq(API, API, comment: [insert to money\ history table, and\ update user money.])

  _seq(API, paymentPage, comment: [return updated data])
  _seq(paymentPage, paymentPage, comment: [display updated\ data as clean\ as possible\ so customer will\ understand.])

  _seq(paymentPage, admin, comment: [give control\ back to admin])
})

#set page(flipped: true)
#pagebreak()

== Customer Add New Money

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(customer)
  _par(paymentPage)
  _par(paymentPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [admin enter\ edit customer\ page], pos: (admin))
  
  _seq(admin, paymentPage, comment: [admin select user to edit\ from dropdown])
  _seq(admin, paymentPage, comment: [admin click add money\ and insert amount])

  _seq(paymentPage, API, comment: [insert new money amount to money table])
  _seq(API, paymentPage, comment: [return 10 latest data of customer insert money])
  _seq(paymentPage, paymentPage, comment: [make data clean\ as possible so\ customer understand\ it well])

  _seq(paymentPage, admin, comment: [give control\ back to admin])
})

== Customer Money Information

#chronos.diagram({
  import chronos: *

  _par(admin)
  _par(customer)
  _par(paymentPage)
  _par(paymentPageState)
  _par(mainPagestate)
  _par(API)

  _note("over", [admin enter\ customer money\ information page], pos: (admin))
  
  _seq(admin, paymentPage, comment: [admin select user to edit\ from dropdown])
  _seq(paymentPage, API, comment: [get all money history including payment and add money])
  _seq(API, paymentPage, comment: [return data])
  _seq(paymentPage, paymentPage, comment: [display returned\ data as clean\ as possible\ so customer\ understand])

  _seq(paymentPage, paymentPage, comment: [display print\ to make printout])

  _seq(paymentPage, admin, comment: [give control\ back to admin])
})
