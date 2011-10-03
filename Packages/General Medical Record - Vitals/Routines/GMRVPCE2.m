GMRVPCE2 ;HIRMFO/RM-V/M Help for AICS ;3/9/99  15:25
 ;;4.0;Vitals/Measurements;**8**;Apr 25, 1997
HELP(TYPE,HLP) ; Entry for Help Screens.  HLP is a closed array reference 
 ; which will have the help returned for measuremnt abbreviation TYPE.
 N X,Y I TYPE="VU" S TYPE="VC"
 F Y=1:1 S X=$T(@TYPE+Y) Q:$P(X,";;",2)="~"  S @HLP@(Y)=$P(X,";;",2,99)
 Q
AG ; HELP FOR ABDOMINAL GIRTH
 ;;Enter Abdominal Girth.  Must be in the range 0-150.
 ;;~
AUD ; HELP FOR AUDIOMETRY.
 ;;Enter 8 readings for right ear followed by 8 readings for left ear, all
 ;;followed by slashes (/).  Values must be between 0 and 110.
 ;;Example:  100/100/100/95/90/90/85/80/105/105/105/105/100/100/95/90/
 ;;~
BP ; HELP FOR BLOOD PRESSURE
 ;;Enter as SYSTOLIC/INTERMEDIATE/DIASTOLIC.  Each pressure is in the range
 ;;of 0-300.  INTERMEDIATE pressure is optional.
 ;;Examples:  98/64 or 120/100/80
 ;;~
FH ; HELP FOR FUNDAL HEIGHT
 ;;Enter a Fundal Height.  Must be in the range 10-50.
 ;;~
FT ; HELP FOR FETAL HEART TONES
 ;;Enter Fetal Heart Tone.  Must be in the range 50-250.
 ;;~
HC ; HELP FOR HEAD CIRCUMFERENCE
 ;;Enter a Head Circumference.  If entered in inches, the measurement must
 ;;be 10-30 inches with three decimal places, but the decimal part must be
 ;;a multiple of .125.
 ;;Examples:  23 or 24.125 or 23.25 or 30.375 or 28.5.
 ;;
 ;;If entered in centimeters, the measurement must be 26-76 centimeters with
 ;;one decimal place.
 ;;Examples:  30.2 or 45
 ;;~
HE ; HELP FOR HEARING
 ;;Enter N for Normal, or A for Abnormal.
 ;;~
HT ; HELP FOR HEIGHT
 ;;Enter Height.  A number in one of the following formats (2 decimals
 ;;allowed):
 ;;    72I (inches)   147C or 147CM (centimeters)
 ;;    5FT10IN or 5'10"" (for 5 feet 10 inches)
 ;;~
PU ; HELP FOR PULSE
 ;;Enter pulse.  Must be in range of 0-300.
 ;;~
RS ; HELP FOR RESPIRATION
 ;;Enter the respiration rate of the patient.  Must be in range of 0-100.
 ;;~
TON ; HELP FOR TONOMETRY
 ;;Enter READING for RIGHT eye, followed by a SLASH (/), followed by the
 ;;READING for LEFT eye.  SLASH is REQUIRED!  Readings are in the range
 ;;of 0-80.
 ;;Examples:  18/18, /20, 18/, 10/13.
 ;;~
TMP ; HELP FOR TEMPERATURE
 ;;Enter Temperature.  Temperature can be entered as degrees Farenheit
 ;;or degrees Centigrade.  Range for degrees Farenheit is 45-120 and
 ;;range for degrees Celcius is 0-45.  Readings can have two decimal places.
 ;;Examples:  100.3F or 37C
 ;;~
VC ; HELP FOR VISION CORRECTED (AND VISION UNCORRECTED)
 ;;Enter denominators only.  The 20/ is assumed.  Enter right eye / left eye
 ;;in form n/n (20/20).  If right eye only enter n (20).  If left eye only
 ;;enter /n (/20).  Must be between 10 and 999.
 ;;~
WT ; HELP FOR WEIGHT
 ;;Enter Weight.  Weight can be entered in pounds (L) or Kilograms (K). 
 ;;Readings in pounds must be in the range 0-1500 and readings in kilograms
 ;;must be in the range of 0-700.  Readings can have two decimal places.
 ;;Examples:  195L or 79.5K
 ;;~
PN ; HELP FOR PAIN
 ;;Enter pain scale number (0-10,99).
 ;;0       = patient verbalizes no pain.
 ;;1 to 10 = patient verbalizes having pain.
 ;;          ( 1=slightly uncomfortable/minimal pain)
 ;;          (10=worst imaginable pain)
 ;;99      = patient unable to respond/communicate pain level.  
 ;;Examples:  99 or 5
 ;;~
