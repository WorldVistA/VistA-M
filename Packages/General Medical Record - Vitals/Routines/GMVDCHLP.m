GMVDCHLP ;HOIFO/DAD,FT-VITALS COMPONENT: HELP TEXT ;9/29/00  09:17
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls         (supported)
 ;
HELP(RESULT,GMVITTYP) ;
 ; *** Get help text ***
 ; Input:
 ;  GMVITTYP = A vital type abbreviation
 ; Output:
 ;  RESULT() = The help text
 N GMVLINE,GMVTXT K RESULT
 S GMVITTYP=$$UP^XLFSTR(GMVITTYP)
 I $T(@GMVITTYP)]"" D
 . F GMVLINE=1:1 S GMVTXT=$P($T(@GMVITTYP+GMVLINE),";;",2) Q:GMVTXT=U  D
 .. S RESULT(GMVLINE)=GMVTXT
 .. Q
 . Q
 Q
 ;;
AG ;;ABDOMINAL GIRTH
 ;;Abdominal girth must be numeric with no decimal places
 ;;Must be in the range 0 - 150 IN (0 - 381 CM).
 ;;^
AUD ;;AUDIOMETRY
 ;;Audiometry is entered as eight readings for right ear followed by
 ;;eight readings for left ear.  Readings are delimited by slashes (/).
 ;;Must be in the range 0 - 110.
 ;;E.g.:
 ;;  100/100/100/95/90/90/85/80/105/105/105/105/100/100/95/90/
 ;;^
BP ;;BLOOD PRESSURE
 ;;Blood Pressure must be in the range 0 - 300 and in one of the
 ;;following formats:
 ;;E.g.:
 ;;  120/80      (systolic / diastolic)
 ;;  120/100/80  (systolic / mean / diastolic)
 ;;  120         (systolic [must have doppler or palpated qualifier])
 ;;^
CG ;;CIRCUMFERENCE/GIRTH
 ;;Circumference/girth must be numeric with a maximum of two decimal
 ;;places.  Must be in the range 0 - 200 IN (0 - 508 CM).
 ;;^
CVP ;;CENTRAL VENOUS PRESSURE
 ;;Central venous pressure must be numeric with a maximum of one decimal
 ;;place.  Must be in the range -13.6 - 136 CM H2O (-10 - 100 mmHg).
 ;;^
FH ;;FUNDAL HEIGHT
 ;;Fundal height must be numeric with no decimal places.
 ;;Must be in the range 10 - 50 IN (25 - 127 CM).
 ;;^
FT ;;FETAL HEART TONES
 ;;Fetal heart tones must be numeric with no decimal places.
 ;;Must be in the range 50 - 250.
 ;;^
HC ;;HEAD CIRCUMFERENCE
 ;;Head circumference if entered in inches must be in the range of
 ;;10 - 30 inches with a maximum of three decimal places, where the
 ;;decimal part must be a multiple of 0.125.
 ;;E.g.:
 ;;  23, 24.125, 23.25, 30.375, 28.5
 ;;Head circumfrence if entered in centimeters must be in the range of
 ;;26 - 76 centimeters with a maximum of two decimal places.
 ;;E.g.:
 ;;  30.2, 45
 ;;^
HE ;;HEARING
 ;;Hearing is entered as N for Normal, or A for Abnormal.
 ;;^
HT ;;HEIGHT
 ;;Height must be numeric with a maximum of two decimal places.
 ;;Must be in the range 1 - 100 IN (2.54 - 254 CM).
 ;;^
P ;;PULSE
 ;;Pulse must be numeric between 0 and 300 with no decimal places.
 ;;^
PN ;;PAIN
 ;;Pain score is entered as one of the following integers.
 ;;  0       = Patient verbalizes no pain.
 ;;  1 to 10 = Patient verbalizes having pain.
 ;;            ( 1 = slightly uncomfortable/minimal pain)
 ;;            (10 = worst imaginable pain)
 ;; 99       = Patient unable to respond/communicate pain level.
 ;;^
PO2 ;;PULSE OXIMETRY
 ;;Pulse oximetry must be numeric with no decimal places.
 ;;The value is interpreted as a percentage (0 - 100 %).
 ;;Supplemental O2 information may also be entered:
 ;;O2 Flow rate must be numeric with a maximum of one decimal place.
 ;;Must be in the range 0.5 - 20 liters / minute.
 ;;O2 concentration must be numeric with no decimal places.
 ;;The value is interpreted as a percentage (0 - 100 %).
 ;;^
R ;;RESPIRATION
 ;;Respiration must be numeric between 0 and 99 with no decimal places.
 ;;^
T ;;TEMPERATURE
 ;;Temperature must be numeric with a maximum of two decimal places.
 ;;Must be in the range 45 - 120 F (7.2 - 48.9 C).
 ;;^
TON ;;TONOMETRY
 ;;Tonometry is entered a reading for right eye, followed by a slash
 ;;(/) followed by a reading for the left eye.  The slash is required.
 ;;Must be in the range 0 - 80.
 ;;E.g.:
 ;;  18/18, /20, 18/, 10/13
 ;;^
VC ;;VISION CORRECTED
 ;;Vision corrected must entered in the form RightEye/LeftEye.  Only
 ;;denominators should be entered, the initial 20/ is assumed.  Must
 ;;be in the range 10 - 999.
 ;;E.g.:
 ;;  20/20  (Right eye 20/20.  Left eye 20/20.)
 ;;  20/    (Right eye 20/20.  No left eye measurement.)
 ;;  /20    (No right eye measurement.  Left eye 20/20.)
 ;;^
VU ;;VISION UNCORRECTED
 ;;Vision uncorrected must entered in the form RightEye/LeftEye.  Only
 ;;denominators should be entered, the initial 20/ is assumed.  Must
 ;;be in the range 10 - 999.
 ;;E.g.:
 ;;  20/20  (Right eye 20/20.  Left eye 20/20.)
 ;;  20/    (Right eye 20/20.  No left eye measurement.)
 ;;  /20    (No right eye measurement.  Left eye 20/20.)
 ;;^
WT ;;WEIGHT
 ;;Weight must be numeric with a maximum of two decimal places.
 ;;Must be in the range 0 - 1500 LB (0 - 681 KG).
 ;;^
