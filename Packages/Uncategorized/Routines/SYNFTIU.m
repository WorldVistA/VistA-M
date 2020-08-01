SYNFTIU  ;ven/gpl - fhir loader utilities ;2018-08-17  3:27 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 ; Encounter TIU note utilities
 q
 ;
TONOTE(ien,enc,line) ; insert a line to the note associated with encounter enc
 ; enc is a pointer to the encounter
 ; ien identifies the patient graph
 ;
 n nroot s nroot=$$NOTEPTR^SYNFTIU(ien,enc)
 q:nroot=""
 ;w !,"add to note: ",line
 i $l(line)>80 d  ;
 . n tline s tline(0)=line
 .
 . d WRAP^DIKCU2(.tline,80)
 . ; ZWR tline
 . n zi
 . f zi=0:1:$o(tline(" "),-1) d  ;
 . . s @nroot@($o(@nroot@(" "),-1)+zi)=tline(zi)
 e  s @nroot@($o(@nroot@(" "),-1)+1)=line
 q
 ;
NOTEPTR(ien,enc) ; returns a global pointer to the note for this encounter
 ; ien is the patient graph
 n root s root=$$setroot^SYNWD("fhir-intake")
 n groot s groot=$na(@root@(ien))
 n encien s encien=$o(@groot@("PSO","rien",enc,""))
 q:encien="" ""
 n nroot s nroot=$na(@groot@("load","encounters",encien,"note"))
 q nroot
 ;
KILLNOTE(ien,enc) ; kill the note for this encounter
 ; used for testing
 n knote s knote=$$NOTEPTR^SYNFTIU(ien,enc)
 q:'$d(@knote)
 k @knote
 q
 ;
CLRNOTES(ien,rien) ; kill all notes for patient ien
 n root s root=$$setroot^SYNWD("fhir-intake")
 n groot s groot=$na(@root@(ien,"load","encounters"))
 n zi s zi=0
 f  s zi=$o(@groot@(zi)) q:+zi=0  d  ;
 . k @groot@(zi,"note")
 . w !,"kill ",groot," ",zi," note"
 q
 ;
T1 ;
 s ien=1640
 s enc="urn:uuid:02eb455c-787c-4abb-8f39-a9675a2db35c"
 w !,"note pointer: ",$$NOTEPTR^SYNFTIU(ien,enc)
 q
 ;
T2 ;
 s ien=1640
 s enc="urn:uuid:02eb455c-787c-4abb-8f39-a9675a2db35c"
 d KILLNOTE^SYNFTIU(ien,enc)
 d TONOTE^SYNFTIU(ien,enc,"Test Note Creation")
 d TONOTE^SYNFTIU(ien,enc,"Patient ien: "_ien)
 d TONOTE^SYNFTIU(ien,enc,"Encounter Id: "_enc)
 q
 ;
