ORWDAL33 ;SLC/DAN - Allergy calls to support windows ;7/27/06  11:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,260**;Dec 17, 1997;Build 26
 ;
CLINUSER(ORY)   ;can user mark allergy as entered in error
 N DIC,X,PRM,Y,ORLST,ORX,PLIST,VALUE
 S DIC=8989.51,DIC(0)="MX",X="OR ALLERGY ENTERED IN ERROR" D ^DIC
 I Y=-1 S ORY=0 Q  ;Parameter not found so quit
 S PRM=+Y
 ;Check USER level
 S ORY=$$GET^XPAR("USR",PRM) I ORY'="" Q
 ;Check USER CLASS
 D ENVAL^XPAR(.ORLST,PRM)
 I ORLST>0 D
 . S ORX="" F  S ORX=$O(ORLST(ORX)) Q:ORX=""  D
 . . Q:ORX'["USR(8930"
 . . I $$ISA^USRLM(DUZ,+ORX) S VALUE(+ORX)=ORLST(ORX,1)
 . S ORX=0 F  S ORX=$O(VALUE(ORX)) Q:'+ORX  D REMOVE(ORX)
 . S ORX=0 F  S ORX=$O(VALUE(ORX)) Q:'+ORX  S VALUE=$G(VALUE)!(VALUE(ORX))
 S ORY=$G(VALUE)
 I ORY'="" Q
 ;Check division and system
 S ORY=$$GET^XPAR("DIV^SYS",PRM) I ORY'="" Q
 S ORY=0 Q
 ;
REMOVE(SUB) ;Remove values at higher level classes
 N IEN
 S IEN=0 F  S IEN=$O(^USR(8930,"AD",SUB,IEN)) Q:'+IEN  D
 .I $D(^USR(8930,"AD",IEN)) D REMOVE(IEN) ;Recursive call
 .K VALUE(IEN)
 Q
