XVEMSLD ;DJB/VSHL**VA KERNEL Library Functions - Measurement [04/17/94];2017-08-15  5:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
MEAS ;;;
 ;;; MEASUREMENT FUNCTIONS - XLFMSMT
 ;;;
 ;;; WEIGHT(val,from,to).......Weight Measurement
 ;;;      Converts metric to U.S. and visa versa.
 ;;;
 ;;;       val = must contain a positive numeric value
 ;;;      from = units of measure of val
 ;;;        to = units of measure to convert val to
 ;;;
 ;;;      Ex: W $$WEIGHT(12,"LB","G")  --> 5448 G
 ;;;
 ;;;    Valid units:
 ;;;       t = metric tons          tn = tons
 ;;;      kg = kilograms            lb = pounds
 ;;;       g = grams                oz = ounces
 ;;;      mg = milligrams           gr = grain
 ;;;
 ;;; LENGTH(val,from,to).......Length Measurement
 ;;;
 ;;;      Ex: W $$LENGTH(12,"IN","CM")  --> 30.480 CM
 ;;;
 ;;;    Valid units:
 ;;;       km = kilometers          mi = miles
 ;;;        m = meters              yd = yards
 ;;;       cm = centimeters         ft = feet
 ;;;       mm = millmeters          in = inches
 ;;;
 ;;; VOLUME(val,from,to).......Weight Measurement
 ;;;
 ;;;      Ex: W $$VOLUME(12,"CF","ML")  --> 339800.832 ML
 ;;;
 ;;;    Valid units:
 ;;;       kl = kiloliter           cf = cubic feet
 ;;;       hl = hectoliter          ci = cubic inch
 ;;;      dal = dekaliter          gal = gallon
 ;;;        l = liters              qt = quart
 ;;;       dl = deciliter           pt = pint
 ;;;       cl = centiliter           c = cup
 ;;;       ml = milliliter          oz = ounze
 ;;;
 ;;; BSA(ht,wt).......Body Surface Area Measurement
 ;;;
 ;;;       ht = height in centimeters
 ;;;       wt = weight in kilograms
 ;;;
 ;;;      Ex: W $$BSA^XLFMSMT(175,86)  --> 1.63
 ;;;      Ex: W $$BSA($$LENGTH^XLFMSMT(69,"IN","CM"),$$WEIGHT^XLFMSMT(180,"LB",...
 ;;;          "KG"))  --> 1.57
 ;;;
 ;;; TEMP(val,from,to).......Temperature Measurement
 ;;;
 ;;;      Ex: W $$TEMP^XLFMSMT(72,"F","C")  --> 22.222 C
 ;;;
 ;;;    Valid units:
 ;;;       f = Fahrenheit           c = Celsius
 ;;;***
