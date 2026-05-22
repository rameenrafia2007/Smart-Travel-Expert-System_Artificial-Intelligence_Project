% ==========================================================
% SMART TRAVEL MANAGEMENT EXPERT SYSTEM
% COMPLETE KNOWLEDGE BASE
% ==========================================================

% ==========================================================
% USER MANAGEMENT MODULE
% ==========================================================

:- dynamic user_pref/2.

user(rin, leisure, moderate, pakistan).
user(ali, business, premium, pakistan).

% ==========================================================
% DESTINATION KNOWLEDGE BASE
% ==========================================================

destination(dubai, business, premium, hot, shopping).
destination(singapore, business, moderate, humid, technology).
destination(london, business, premium, cold, historical).
destination(bali, leisure, moderate, tropical, beaches).
destination(thailand, leisure, affordable, hot, adventure).
destination(maldives, leisure, premium, tropical, honeymoon).
destination(switzerland, leisure, premium, cold, honeymoon).
destination(skardu, leisure, affordable, cold, mountains).
destination(turkey, leisure, moderate, pleasant, history).
destination(paris, leisure, premium, cold, romance).

% ==========================================================
% TRANSPORTATION MANAGEMENT MODULE
% ==========================================================

transport(dubai, flight, 120000).
transport(singapore, flight, 150000).
transport(london, flight, 200000).
transport(bali, flight, 110000).
transport(thailand, flight, 100000).
transport(skardu, bus, 5000).

% ==========================================================
% HOTEL & ACCOMMODATION MODULE
% ==========================================================

hotel(burj_hotel, dubai, premium).
hotel(marina_bay_hotel, singapore, premium).
hotel(budget_bali_inn, bali, affordable).
hotel(thai_resort, thailand, affordable).
hotel(maldives_water_villa, maldives, premium).
hotel(skardu_guest_house, skardu, affordable).

% ==========================================================
% TRAVEL PACKAGE MODULE
% ==========================================================

package(dubai, five_days, 150000).
package(bali, four_days, 80000).
package(skardu, three_days, 25000).

% ==========================================================
% BUDGET PLANNING MODULE
% ==========================================================

estimate_cost(Place, Total) :-
    transport(Place, _, TCost),
    (hotel(_, Place, affordable) -> HCost = 5000 ; HCost = 20000),
    Total is TCost + HCost.

% ==========================================================
% WEATHER & SEASONAL ADVISORY MODULE
% ==========================================================

weather_risk(thailand, 'High Monsoon Risk').
weather_risk(skardu, 'Heavy Snowfall').
weather_risk(dubai, 'Extreme Heat').
weather_risk(switzerland, 'Extreme Cold').

% ==========================================================
% VISA & DOCUMENTATION MODULE
% ==========================================================

visa_required(pakistan, dubai, yes).
visa_required(pakistan, singapore, no).
visa_required(pakistan, london, yes).
visa_required(pakistan, bali, no).
visa_required(pakistan, thailand, no).
visa_required(pakistan, switzerland, yes).

% ==========================================================
% RESTAURANT & FOOD RECOMMENDATION MODULE
% ==========================================================

famous_food(thailand, spicy_noodles).
famous_food(turkey, kebab).
famous_food(paris, french_pastries).
famous_food(dubai, mandi).
famous_food(bali, seafood).

% ==========================================================
% SAFETY & SECURITY MODULE
% ==========================================================

safety_status(dubai, safe).
safety_status(switzerland, very_safe).
safety_status(thailand, moderate).
safety_status(skardu, safe).

% ==========================================================
% EVENT & FESTIVAL MODULE
% ==========================================================

festival(dubai, shopping_festival).
festival(germany, oktoberfest).
festival(paris, fashion_week).
festival(brazil, carnival).

% ==========================================================
% CURRENCY & EXPENSE CONVERSION MODULE
% ==========================================================

exchange_rate(usd, pkr, 280).

convert_currency(Amount, Converted) :-
    exchange_rate(usd, pkr, Rate),
    Converted is Amount * Rate.

% ==========================================================
% TRAVEL INSURANCE MODULE
% ==========================================================

insurance_required(switzerland, yes).
insurance_required(dubai, no).
insurance_required(london, yes).

% ==========================================================
% REVIEW & RATING ANALYSIS MODULE
% ==========================================================

rating(dubai, 4.5).
rating(bali, 4.7).
rating(skardu, 4.2).
rating(switzerland, 4.9).

% ==========================================================
% EMERGENCY ASSISTANCE MODULE
% ==========================================================

emergency_contact(dubai, police_999).
emergency_contact(skardu, rescue_1122).
emergency_contact(london, emergency_999).

% ==========================================================
% INTELLIGENT ITINERARY PLANNING MODULE
% ==========================================================

itinerary(dubai, day1, shopping).
itinerary(dubai, day2, desert_safari).
itinerary(bali, day1, beach_visit).
itinerary(bali, day2, temple_visit).
itinerary(skardu, day1, trekking).

% ==========================================================
% AI PREFERENCE LEARNING MODULE
% ==========================================================

learn_preference(Type, Budget) :-
    assert(user_pref(Type, Budget)).

% ==========================================================
% INFERENCE ENGINE
% ==========================================================

recommend_trip(Place) :-
    user_pref(Type, Budget),
    destination(Place, Type, Budget, _, _).

honeymoon_place(Place) :-
    destination(Place, leisure, premium, _, honeymoon).

adventure_trip(Place) :-
    destination(Place, leisure, affordable, _, adventure).

check_visa(Place, Msg) :-
    visa_required(pakistan, Place, yes)
    -> Msg = 'Visa Required'
    ; Msg = 'No Visa Required'.

safe_destination(Place) :-
    safety_status(Place, safe);
    safety_status(Place, very_safe).

recommend_hotel(Place, Hotel) :-
    hotel(Hotel, Place, affordable).

% ==========================================================
% EXPLANATION & JUSTIFICATION MODULE
% ==========================================================

explain_recommendation(Place, Msg) :-
    destination(Place, Type, Budget, _, _),
    format(atom(Msg),
    'Recommended because it matches ~w travel and ~w budget.',
    [Type, Budget]).

% ==========================================================
% CHATBOT SYSTEM
% ==========================================================

start :-
    write('===================================='), nl,
    write(' SMART TRAVEL MANAGEMENT SYSTEM '), nl,
    write('===================================='), nl,
    chatbot.

chatbot :-
    repeat,
    nl,
    write('1. Recommend Trip'), nl,
    write('2. Visa Check'), nl,
    write('3. Cost Estimate'), nl,
    write('4. Safe Destinations'), nl,
    write('5. Famous Food'), nl,
    write('6. Exit'), nl,
    read(Choice),
    handle(Choice),
    Choice == 6, !.

% ==========================================================
% HANDLE USER CHOICES
% ==========================================================

handle(1) :-
    write('Trip Type (business/leisure): '),
    read(T),
    write('Budget (affordable/moderate/premium): '),
    read(B),
    learn_preference(T,B),
    (recommend_trip(P) ->
        write('Recommended Destination: '), write(P), nl
    ;
        write('No suitable destination found.'), nl).

handle(2) :-
    write('Enter destination: '),
    read(P),
    check_visa(P, Msg),
    write(Msg), nl.

handle(3) :-
    write('Enter destination: '),
    read(P),
    estimate_cost(P, Cost),
    write('Estimated Cost: '), write(Cost), nl.

handle(4) :-
    safe_destination(P),
    write(P), nl,
    fail.
handle(4).

handle(5) :-
    write('Enter destination: '),
    read(P),
    (famous_food(P,F) ->
        write('Famous Food: '), write(F), nl
    ;
        write('Food information unavailable.'), nl).

handle(6) :-
    write('Thank You For Using Smart Travel Expert System!'), nl.

handle(_) :-
    write('Invalid Choice'), nl.

% ==========================================================
% SAMPLE QUERIES
% ==========================================================

% ?- start.
% ?- recommend_trip(X).
% ?- honeymoon_place(X).
% ?- adventure_trip(X).
% ?- check_visa(dubai, X).
% ?- estimate_cost(skardu, X).
% ?- safe_destination(X).
% ?- famous_food(paris, X).