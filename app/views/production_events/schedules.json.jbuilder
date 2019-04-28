json.array! @mos, partial: 'production_events/mo', as: :mo
json.array! @production_events, partial: 'production_events/production_event', as: :production_event
