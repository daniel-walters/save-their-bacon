class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
        @name = params[:name]
    end

    def create_payment_intent
        animal = Animal.find(params[:id])

        session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user&.email,
            line_items: [{
                name: animal.name,
                description: animal.bio,
                amount: animal.sponsor_price,
                currency: 'aud',
                quantity: 1
            }],
            payment_intent_data: {
                metadata: {
                    user_id: current_user&.id,
                    animal_id: animal.id
                }
            },
            success_url: "#{root_url}/payments/success?name=#{animal.name}",
            cancel_url: "#{root_url}/animals"
        )

        @session_id = session.id
    end

    #create sponsorship and chat on stripe success
    def webhook
        payment_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        animal_id = payment.metadata.animal_id
        sponsor_id = payment.metadata.user_id
        animal = Animal.find(animal_id)
        animal.update(sponsored: true)
        s = Sponsorship.create(receipt: payment.charges.data[0].receipt_url, animal_id: animal_id, sponsor_id: sponsor_id, owner_id: animal.owner.id)
        Chat.create(sponsorship_id: s.id)
    end 
end
