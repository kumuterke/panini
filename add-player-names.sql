-- Run this ONCE in Supabase SQL Editor.
-- Adds sticker/player names without changing your existing inventory or permissions.

alter table public.stickers
add column if not exists player_name text;

update public.stickers set player_name = 'Cameron Burgess' where team = 'AUS' and number = 8;
update public.stickers set player_name = 'Team Photo' where team = 'AUS' and number = 13;
update public.stickers set player_name = 'Team Logo' where team = 'AUT' and number = 1;
update public.stickers set player_name = 'David Alaba' where team = 'AUT' and number = 4;
update public.stickers set player_name = 'Youri Tielemans' where team = 'BEL' and number = 9;
update public.stickers set player_name = 'Leandro Trossard' where team = 'BEL' and number = 18;
update public.stickers set player_name = 'Loïs Openda' where team = 'BEL' and number = 19;
update public.stickers set player_name = 'Alisson' where team = 'BRA' and number = 2;
update public.stickers set player_name = 'Bento' where team = 'BRA' and number = 3;
update public.stickers set player_name = 'Samuel Adekugbe' where team = 'CAN' and number = 5;
update public.stickers set player_name = 'Evan Ndicka' where team = 'CIV' and number = 6;
update public.stickers set player_name = 'Simon Adingra' where team = 'CIV' and number = 17;
update public.stickers set player_name = 'Yerry Mina' where team = 'COL' and number = 5;
update public.stickers set player_name = 'Jhon Lucumí' where team = 'COL' and number = 8;
update public.stickers set player_name = 'Duje Caleta-Car' where team = 'CRO' and number = 3;
update public.stickers set player_name = 'Petar Sucic' where team = 'CRO' and number = 15;
update public.stickers set player_name = 'Gonzalo Valle' where team = 'ECU' and number = 3;
update public.stickers set player_name = 'Team Photo' where team = 'EGY' and number = 13;
update public.stickers set player_name = 'Emam Ashour' where team = 'EGY' and number = 15;
update public.stickers set player_name = 'Jordan Pickford' where team = 'ENG' and number = 2;
update public.stickers set player_name = 'Jordan Henderson' where team = 'ENG' and number = 9;
update public.stickers set player_name = 'Marc Cucurella' where team = 'ESP' and number = 8;
update public.stickers set player_name = 'Uruguay 1950 - World Cup History' where team = 'FWC' and number = 10;
update public.stickers set player_name = 'Waldemar Anton' where team = 'GER' and number = 7;
update public.stickers set player_name = 'Serge Gnabry' where team = 'GER' and number = 16;
update public.stickers set player_name = 'Nick Woltemade' where team = 'GER' and number = 20;
update public.stickers set player_name = 'Ricardo Adé' where team = 'HAI' and number = 6;
update public.stickers set player_name = 'Garven Metusala' where team = 'HAI' and number = 8;
update public.stickers set player_name = 'Danley Jean Jacques' where team = 'HAI' and number = 11;
update public.stickers set player_name = 'Ruben Providence' where team = 'HAI' and number = 17;
update public.stickers set player_name = 'Team Photo' where team = 'IRN' and number = 13;
update public.stickers set player_name = 'Zaid Tahseen' where team = 'IRQ' and number = 7;
update public.stickers set player_name = 'Ihsan Haddad' where team = 'JOR' and number = 3;
update public.stickers set player_name = 'Shogo Taniguchi' where team = 'JPN' and number = 6;
update public.stickers set player_name = 'Kaishu Sano' where team = 'JPN' and number = 8;
update public.stickers set player_name = 'Ao Tanaka' where team = 'JPN' and number = 10;
update public.stickers set player_name = 'Shuto Machino' where team = 'JPN' and number = 17;
update public.stickers set player_name = 'Koki Ogawa' where team = 'JPN' and number = 19;
update public.stickers set player_name = 'Team Photo' where team = 'KOR' and number = 13;
update public.stickers set player_name = 'Jens Castrop' where team = 'KOR' and number = 15;
update public.stickers set player_name = 'Hee-chan Hwang' where team = 'KOR' and number = 19;
update public.stickers set player_name = 'Luis Malagón' where team = 'MEX' and number = 2;
update public.stickers set player_name = 'Johan Vasquez' where team = 'MEX' and number = 3;
update public.stickers set player_name = 'Cesar Montes' where team = 'MEX' and number = 5;
update public.stickers set player_name = 'Orbelin Pineda' where team = 'MEX' and number = 11;
update public.stickers set player_name = 'Yassine Bounou' where team = 'MOR' and number = 2;
update public.stickers set player_name = 'Munir El Kajoui' where team = 'MOR' and number = 3;
update public.stickers set player_name = 'Roman Saiss' where team = 'MOR' and number = 7;
update public.stickers set player_name = 'Brahim Diaz' where team = 'MOR' and number = 19;
update public.stickers set player_name = 'Bart Verbruggen' where team = 'NED' and number = 2;
update public.stickers set player_name = 'Jan Paul van Hecke' where team = 'NED' and number = 9;
update public.stickers set player_name = 'Teun Koopmeiners' where team = 'NED' and number = 12;
update public.stickers set player_name = 'Memphis Depay' where team = 'NED' and number = 17;
update public.stickers set player_name = 'Donyell Malen' where team = 'NED' and number = 18;
update public.stickers set player_name = 'Kristoffer Vassbakk Ajer' where team = 'NOR' and number = 5;
update public.stickers set player_name = 'Antonio Nusa' where team = 'NOR' and number = 19;
update public.stickers set player_name = 'Fidel Escobar' where team = 'PAN' and number = 4;
update public.stickers set player_name = 'Jose Cordoba' where team = 'PAN' and number = 8;
update public.stickers set player_name = 'Orlando Gill' where team = 'PAR' and number = 3;
update public.stickers set player_name = 'Team Logo' where team = 'POR' and number = 1;
update public.stickers set player_name = 'Bernardo Silva' where team = 'POR' and number = 9;
update public.stickers set player_name = 'Sultan Albrake' where team = 'QAT' and number = 3;
update public.stickers set player_name = 'Lucas Mendes' where team = 'QAT' and number = 4;
update public.stickers set player_name = 'Tarek Salman' where team = 'QAT' and number = 8;
update public.stickers set player_name = 'Ahmed Fatehi' where team = 'QAT' and number = 12;
update public.stickers set player_name = 'Hassan Al-Haydos' where team = 'QAT' and number = 16;
update public.stickers set player_name = 'Khulumani Ndamane' where team = 'RSA' and number = 7;
update public.stickers set player_name = 'Nkosinathi Sibisi' where team = 'RSA' and number = 10;
update public.stickers set player_name = 'Lyle Foster' where team = 'RSA' and number = 17;
update public.stickers set player_name = 'Iqraam Rayners' where team = 'RSA' and number = 18;
update public.stickers set player_name = 'Habib Diarra' where team = 'SEN' and number = 12;
update public.stickers set player_name = 'Boulaye Dia' where team = 'SEN' and number = 17;
update public.stickers set player_name = 'Team Logo' where team = 'SWE' and number = 1;
update public.stickers set player_name = 'Yasin Ayari' where team = 'SWE' and number = 11;
update public.stickers set player_name = 'Ken Sema' where team = 'SWE' and number = 15;
update public.stickers set player_name = 'Anthony Elanga' where team = 'SWE' and number = 18;
update public.stickers set player_name = 'Yan Valery' where team = 'TUN' and number = 4;
update public.stickers set player_name = 'Montassar Talbi' where team = 'TUN' and number = 5;
update public.stickers set player_name = 'Yassine Meriah' where team = 'TUN' and number = 6;
update public.stickers set player_name = 'Ali Abdi' where team = 'TUN' and number = 7;
update public.stickers set player_name = 'Team Photo' where team = 'TUN' and number = 13;
update public.stickers set player_name = 'Giorgian De Arrascaeta' where team = 'URU' and number = 11;
update public.stickers set player_name = 'Team Photo' where team = 'URU' and number = 13;
update public.stickers set player_name = 'Brenden Aaronson' where team = 'USA' and number = 17;

-- Optional verification:
select team, number, player_name, quantity
from public.stickers
order by team, number;
