###
@TODO

@namespace Atoms.Organism
@class AppnimaSession

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.AppnimaCreditCard extends Atoms.Organism.Modal

  @extends: true

  @default:
    children: [
      "Organism.Header":
        "id": "header"
        "children": [
          "Atom.Icon": icon: "ios7-checkmark-outline"
        ,
          "Atom.Heading": id: "title"
        ]
    ,
      "Organism.Section": {
        "id": "section"
        "children": [
          "Molecule.Form":
            "id": "cards"
            "children": [
              "Atom.Select": {}
            ,
              "Atom.Button":
                "style": "fluid accept"
                "text": "Payment"
            ]
        ,
          "Molecule.Form":
            "id": "card"
        ]
      }
    ,
      "Organism.Footer": {

      }
    ]

  @events: ["error"]

  render: ->
    super
    unless window.Appnima?
      alert "ERROR: App/nima library not exists."

  purchase: (amount=0, description, provider=0) ->
    window.Appnima.User.session()
    if window.Appnima?.key? and window.Appnima?.token?
      Atoms.App.Modal.Loading.show()
      Appnima.Payments.getCreditCards().then (error, result) =>
        Atoms.App.Modal.Loading.hide()
        console.log error, result
        creditcards = result.creditcards


        @header.title.el.html description if description?
        #
        @section.cards.el.show()
        @section.card.el.hide()
        #
        @show()
    else
      alert "ERROR: Unknown App/nima key or token"

new Atoms.Organism.AppnimaCreditCard()
