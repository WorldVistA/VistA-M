DVBCVSC2 ;ALB ISC/THM-FIELD CHART FOR VISUAL EXAM ; 6/27/91  2:10 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;**This program is temporarily not used -- thm 6/27/91
 ;
 F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 Q
 ;
TXT ;
 ;;Visual Fields in Degrees
 ;;
 ;;Meridian                  Right Eye                 Left Eye
 ;;________                  _________                 ________
 ;;
 ;;
 ;;Up                        _________                 _________
 ;
 ;;  Up+                     (_______)                 (_______)
 ;;
 ;;Up nasal                  _________                 _________
 ;;
 ;;  Up nasal+               (_______)                 (_______)
 ;;
 ;;Nasal                     _________                 _________
 ;;
 ;;  Nasal+                  (_______)                 (_______)
 ;;
 ;;Down nasal                _________                 _________
 ;;
 ;;  Down nasal+             (_______)                 (_______)
 ;;
 ;;Down                      _________                 _________
 ;;
 ;;  Down+                   (_______)                 (_______)
 ;;
 ;;Down temporal             _________                 _________
 ;;
 ;;  Down temporal+          (_______)                 (_______)
 ;;
 ;;Temporal                  _________                 _________
 ;;
 ;;  Temporal+               (_______)                 (_______)
 ;;
 ;;Up temporal               _________                 _________
 ;;
 ;;  Up temporal+            (_______)                 (_______)
 ;;
 ;;
 ;;"Up+" indicates a meridian about halfway between "Up" and "Up nasal",
 ;;"Nasal+" a meridian intermediate between "Nasal" and "Down nasal".  These
 ;;intermediate meridians are not used for evaluation purposes but are required
 ;;for smoothing the curves of the charted field(s).
 ;;END
