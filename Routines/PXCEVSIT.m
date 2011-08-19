PXCEVSIT ;slc/dee,ISA/KWP-Used in editing a visit ; 1/7/02 11:36am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9,23,70,116,147,151**;Aug 12, 1996
 Q
 ;
 ;********************************
 ;
 ;Functions
 ;
ELIGIBIL(PATIENT,HOSPLOC,DATETIME) ;+Eligibility from appointment if there is one.
 Q:$G(PATIENT)'>0 -1
 Q:$G(HOSPLOC)'>0 -1
 Q:$G(DATETIME)'>1600000 -1
 Q:'($D(^SC(HOSPLOC,"S",DATETIME,1))\10) -1
 N PXCEELIG,PXCEINDX
 S PXCEELIG=-1
 S PXCEINDX=0
 F  S PXCEINDX=$O(^SC(HOSPLOC,"S",DATETIME,1,PXCEINDX)) Q:PXCEINDX=""  I $P($G(^SC(HOSPLOC,"S",DATETIME,1,PXCEINDX,0)),"^",1)=PATIENT S PXCEELIG=$S($P(^(0),"^",10)>0:$P(^(0),"^",10),1:-1) Q
 Q PXCEELIG
 ;
 ;********************************
 ;Special cases for edit of the visit.
 ;
EVISITDT(REQTIME,DEFAULT) ;
 ;+REQTIME is 1 if time is required,
 ;+           0 if time is optional
 ;+          -1 if the date can be imprecise
 ;+DEFAULT is the default date/time is there is not one in the file.
 ;+        If it is -1 then NOW will be used as the default.
 ;+        If it is 0 then TODAY will be used as the default.
 N PXLIMDT
 S PXLIMDT=$S(PXCECAT="HIST":0,1:$$SWITCHD^PXAPI)
 S DIR(0)="DO^"_$S(PXLIMDT>2960000:PXLIMDT,1:"")_":"_(DT+.24)_":ESP"
 I $G(REQTIME)=1 S DIR(0)=DIR(0)_"RX"
 E  I $G(REQTIME)=-1 S DIR(0)=DIR(0)_"T"
 E  S DIR(0)=DIR(0)_"TX"
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" S DIR("B")=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 E  I ($D(DEFAULT)#2) D
 . N %H,%I,%
 . I DEFAULT>0 S DIR("B")=DEFAULT
 . E  I DEFAULT=0 S DIR("B")=DT
 . E  I DEFAULT=-1 D NOW^%DTC S DIR("B")=%
 I $D(DIR("B"))#2 S Y=DIR("B") D DD^%DT S DIR("B")=Y
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 I '$D(DIRUT),'$D(DUOUT),+VADM(6),$P(Y,".")>+VADM(6) S (DIRUT,DUOUT)=1 W VADM(7) R Y:10
 K DIR,DA
 Q
 ;
 ;
EHOSPLOC ;
 N HLOC,PXRES
 I $P(PXCEAFTR(0),"^",22)'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="PA^44:AEMQ"
 S DIR("A")=$P(PXCETEXT,"~",4)
 I $P(PXCETEXT,"~",8)]"" S DIR("?")=$P(PXCETEXT,"~",8)
 ;Only clinics that are not occasion of service 
 ; and are not dispositioning clinics
 ;S DIR("S")="I $P(^(0),U,3)=""C""&'+$G(^(""OOS""))&'$O(^PX(815,1,""DHL"",""B"",Y,0))"
 ;Only hospital locations that are not dispositioning clinics
 ;
 ;not occasion of service and not dispositioning clinics
 ;S DIR("S")="I '+$G(^(""OOS""))&'$O(^PX(815,1,""DHL"",""B"",Y,0))"
 ;Exclude disposition clinics from the above listed condition.
 S DIR("S")="I '+$G(^(""OOS""))" ;PX*1*116
 D ^DIR
 K DIR,DA
 I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q
 I +Y'>0,PXCECAT'="HIST" D HELPHLOC W !,$C(7) G EHOSPLOC
 S HLOC=$S(+Y>0:+Y,1:"")
 I HLOC'="" S PXRES=$$CLNCK^SDUTL2(HLOC,1) I 'PXRES D  G EHOSPLOC
 .W !,$C(7),?5,"Clinic MUST be corrected before continuing."
 S $P(PXCEAFTR(0),"^",22)=HLOC
 ;
 ;Get the eligibility and appointment type
 ;  if there is not already an appointment.
 ;  Creating a new visit or will lookup and find an old visit.
 I '$$APPOINT^PXUTL1(PXCEPAT,+PXCEAFTR(0),HLOC) D
 . S PXELAP=$$ELAP^SDPCE($P(PXCEAFTR(0),"^",5),$P(PXCEAFTR(0),"^",22))
 E  I HLOC>0 D
 . ;Get the ELIGIBILITY for the appointment if there is one.
 . N PXCEELIG
 . S PXCEELIG=$$ELIGIBIL(PXCEPAT,HLOC,$P(PXCEAFTR(0),"^",1))
 . S:PXCEELIG>0 $P(PXCEAFTR(0),"^",21)=PXCEELIG
 Q
 ;
HELPDISP ;
 W !,"You can not select a Dispositioning Clinic."
 Q
 ;
HELPHLOC ;
 W !!,"Enter the name of the Clinic for this Encounter."
 W !,"Hospital Location is required."
 Q
 ;
EWORKLOD(ASK) ;
 ;+If ASK=0 do not ask default to the one for the Hospital Location
 N DIC,DA
EWORKLD2 ;
 K DTOUT,DUOUT,DIC,DA
 I $P(PXCEAFTR(0),"^",8)+$P(PXCEAFTR(0),"^",22) D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . I $P(PXCEAFTR(0),"^",8)'="" S PXCEINT=$P(PXCEAFTR(0),"^",8)
 . E  S PXCEINT=$P(^SC($P(PXCEAFTR(0),"^",22),0),"^",7)
 . S Y=+PXCEINT
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIC("B")=$S('$D(DIERR):PXCEEXT,1:$P(PXCEAFTR(0),"^",8))
 S DIC="^DIC(40.7,"
 S DIC(0)="AEM"
 S DIC("S")="I $P(^(0),U,3)=""""!($P(^(0),U,3)'<$P(PXCEAFTR(0),U))"
 S DIC("A")=$P(PXCETEXT,"~",4)
 I Y'>0!ASK D
 . D ^DIC
 K DIR,DA
 I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q
 I +Y'>0,PXCECAT'="HIST" G EWORKLD2
 ;+set the stop code into the visit file
 S $P(PXCEAFTR(0),"^",8)=$S(+Y>0:+Y,1:"")
 N PXHLOC,PXSC
 S PXHLOC=$P(PXCEAFTR(0),"^",22)
 S PXSC=$P($G(^SC(+PXHLOC,0)),"^",7)
 ;+if the hospital location is a ward then set the encounter type to a P for primary
 I $P($G(^SC(+PXHLOC,0)),"^",3)["W" S $P(PXCEAFTR(150),"^",3)="P" Q
 ;+if the stop code on file for the hospital location is the stop code entered or if the stop code in the hospital location file is null then set the encounter type to P for primary
 I PXSC=+Y!(PXSC=""&PXHLOC) S $P(PXCEAFTR(150),"^",3)="P"
 Q
 ;
ECODT ;Check out date time
 N PXCHKOUT
 D CHIKOUT^PXBAPI2("",PXCEPAT,+$P(PXCEAFTR(0),"^",22),$P(PXCEAFTR(0),"^",1))
 S:PXCHKOUT>0 $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=PXCHKOUT
 Q
 ;
EPAT ;
 I $P(PXCEAFTR(0),"^",5)'="" Q
 S DIR(0)="9000010,.05A"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;for visit
 S $P(PXCEAFTR(0),"^",5)=$P(Y,"^")
 S PXCEPAT=$P(Y,"^") D PATINFO^PXCEPAT(.PXCEPAT) I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1  ;PX*1*147
 Q
 ;
SKIP ;Just returns used when need a edit routine that does nothing.
 Q
 ;
