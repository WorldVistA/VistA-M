SDTMP704 ;;MS/PB - TMP POST INSTALL;July 05, 2018
 ;;5.3;Scheduling;**704**;May 29, 2018;Build 64
 ;Post install routine to create new indexes in Patch SD*5.3*704
 ;This routine will be deleted at the end of the install
 ;by the KIDS install process
 Q
EN ;
 D LINK
 D ATMP1
 D AX298
 D AY298
 Q
LINK ; update the TMP_Send Link
 N LIEN,OPSITE,DOMAIN,VAL,SDERR
 S VAL="TMP_Send"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL) ;Q:'LIEN
 I $G(LIEN)>0 D
 .S FDA(870,LIEN_",",.02)=$$KSP^XUPARAM("INST") ; site station number
 .S FDA(870,LIEN_",",4.5)=1 ; auto start
 .S FDA(870,LIEN_",",400.01)="vaauscluhshhl7rtr401.aac.domain.ext" ; ip address
 .S FDA(870,LIEN_",",400.02)=6950 ; hl7 port
 .S FDA(870,LIEN_",",400.08)=6950 ; hlo port
 .D UPDATE^DIE(,"FDA","SDERR") K FDA
 .D MES^XPDUTL("")
 I $G(LIEN)'>0 D
 .K DIC,DIC(0),X,Y,DLAYGO
 .S DIC="^HLCS(870,",DLAYGO=870,DIC(0)="L",X="TMP_SEND" D FILE^DICN
 .I +$G(Y)'>0 D MES^XPDUTL("Unable to create the new TMP_SEND HL Logical Link.")
 .S LIEN=+Y
 .S FDA(870,LIEN_",",.02)=$$KSP^XUPARAM("INST") ; site station number
 .S FDA(870,LIEN_",",4.5)=1 ; auto start
 .S FDA(870,LIEN_",",400.01)="vaauscluhshhl7rtr401.aac.domain.ext" ; ip address
 .S FDA(870,LIEN_",",400.02)=6950 ; hl7 port
 .S FDA(870,LIEN_",",400.08)=6950 ; hlo port
 .D UPDATE^DIE(,"FDA","SDERR") K FDA
 .D MES^XPDUTL("")
 .Q
 I $D(SDERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the TMP_Send Link.")
 D MES^XPDUTL("TMP_Send Link has been updated.")
 Q
ATMP1 ; creates a new style index on the Hospital Location File (#44)
 ;Q:$O(^DD("IX","BB",44,"ATMP1",0))
 N SDTMPX,SDTMPY
 S SDTMPX("FILE")=44,SDTMPX("NAME")="ATMP1"
 I $O(^DD("IX","BB",SDTMPX("FILE"),SDTMPX("NAME"),0)) D DELIXN^DDMOD(SDTMPX("FILE"),SDTMPX("NAME"))
 S SDTMPX("TYPE")="MU",SDTMPX("USE")="A"
 S SDTMPX("EXECUTION")="F",SDTMPX("ACTIVITY")="IR"
 S SDTMPX("SHORT DESCR")="TMP HL7"
 S SDTMPX("DESCR",1)="The Tele Health Management Platform (TMP) application"
 S SDTMPX("DESCR",2)="allows users to schedule and cancel appointments in VistA."
 S SDTMPX("DESCR",3)="TMP needs to be kept up to date with specific clinic"
 S SDTMPX("DESCR",4)="information in order to be able to accurately display"
 S SDTMPX("DESCR",5)="clinic information."
 S SDTMPX("DESCR",6)=""
 S SDTMPX("DESCR",7)="This index will trigger an update to be sent to the TMP"
 S SDTMPX("DESCR",8)="platform via HL7 when one of the fields below is edited for"
 S SDTMPX("DESCR",9)="a tele health clinic or if a new tele health clinic is"
 S SDTMPX("DESCR",10)="added. Tele health clinics are identified by either the"
 S SDTMPX("DESCR",11)="Stop Code Number (primary stop code) or the Credit Stop"
 S SDTMPX("DESCR",12)="Code (secondary stop code)."
 S SDTMPX("DESCR",13)=""
 S SDTMPX("DESCR",14)="Name (#.01) Stop Code Number (#8) Credit Stop Code (#2504)"
 S SDTMPX("DESCR",15)="Service (#9) Treating Specialty (#9.5) Overbooks/Day"
 S SDTMPX("DESCR",16)="Maximum (#1918) Inactivate Date (#2505) Reactivate Date"
 S SDTMPX("DESCR",17)="(#2506)."
 S SDTMPX("SET CONDITION")="S X=X1(1)'=""""!X1(2)'=""""!X1(3)'=""""!X1(4)'=""""!X1(5)'=""""!X1(6)'=""""!X1(7)'=""""!X1(8)'=""""!X1(9)'="""""
 S SDTMPX("SET")="D EN^SDTMPHLB(DA)"
 S SDTMPX("KILL")="Q"
 ;S SDTMPX("WHOLE KILL")="Q"
 S SDTMPX("VAL",1)=.01 ;Name
 S SDTMPX("VAL",2)=8 ;Stop Code Number
 S SDTMPX("VAL",3)=2503 ;Credit Stop Code
 S SDTMPX("VAL",4)=9.5 ;Treating Specialty
 S SDTMPX("VAL",5)=9 ;Service
 S SDTMPX("VAL",6)=16 ;Default Provider
 S SDTMPX("VAL",7)=1918 ;Overbooks/Day Maximum
 S SDTMPX("VAL",8)=2505 ;Inactive date
 S SDTMPX("VAL",9)=2506 ;Reactivate date
 D CREIXN^DDMOD(.SDTMPX,"",.SDTMPY) ;SDTMPY=ien^name of index
 I +$G(SDTMPY)>0 N IEN S IEN=+SDTMPY,^DD("IX",IEN,"NOREINDEX")=1
 Q
 ;
AX298 ; creates the ATMP1 cross reference in the appointment multiple in the patient file.
 ;Q:$O(^DD("IX","BB",2,"AX",0))
 N SDTMPX,SDTMPY
 S SDTMPX("FILE")=2,SDTMPX("NAME")="AX",SDTMPX("ROOT FILE")=2.98
 I $O(^DD("IX","BB",SDTMPX("FILE"),SDTMPX("NAME"),0)) D DELIXN^DDMOD(SDTMPX("FILE"),SDTMPX("NAME"))
 S SDTMPX("TYPE")="MU",SDTMPX("USE")="A"
 S SDTMPX("EXECUTION")="R",SDTMPX("ACTIVITY")="IR"
 S SDTMPX("SHORT DESCR")="Action cross reference to send HL7 notification to TMP when a new appt is made."
 S SDTMPX("DESCR",1)="The Tele Health Management Platform (TMP)"
 S SDTMPX("DESCR",2)="application allows users to schedule and cancel"
 S SDTMPX("DESCR",3)="tele health appointments in VistA. TMP needs to"
 S SDTMPX("DESCR",4)="be kept up to date with appointments scheduled"
 S SDTMPX("DESCR",5)="by other applications in order to be able to"
 S SDTMPX("DESCR",6)="accurately display open appointment slots. This"
 S SDTMPX("DESCR",7)="index will trigger an HL7 message sent to TMP"
 S SDTMPX("DESCR",8)="that will update the clinic's and patient's"
 S SDTMPX("DESCR",9)="appointments in the TMP database system."
 S SDTMPX("SET CONDITION")="S X=X1(1)="""""
 S SDTMPX("SET")="D EN^SDTMPHLA(DA(1),DA)"
 S SDTMPX("KILL")="Q"
 ;S SDTMPX("WHOLE KILL")="Q"
 S SDTMPX("VAL",1)=.01 ;Name
 D CREIXN^DDMOD(.SDTMPX,"",.SDTMPY) ;SDTMPY=ien^name of index
 I +$G(SDTMPY)>0 N IEN S IEN=+SDTMPY,^DD("IX",IEN,"NOREINDEX")=1
 Q
 ;
AY298 ; creates the ATMP1 cross reference in the appointment multiple in the patient file.
 ;Q:$O(^DD("IX","BB",2,"AY",0))
 N SDTMPX,SDTMPY
 S SDTMPX("FILE")=2,SDTMPX("NAME")="AY",SDTMPX("ROOT FILE")=2.98
 I $O(^DD("IX","BB",SDTMPX("FILE"),SDTMPX("NAME"),0)) D DELIXN^DDMOD(SDTMPX("FILE"),SDTMPX("NAME"))
 S SDTMPX("TYPE")="MU",SDTMPX("USE")="A"
 S SDTMPX("EXECUTION")="F",SDTMPX("ACTIVITY")="IR"
 S SDTMPX("SHORT DESCR")="Action cross reference to send an HL7 notification when an appt is cancelled."
 S SDTMPX("DESCR",1)="The Tele Health Management Platform (TMP)"
 S SDTMPX("DESCR",2)="application allows users to schedule and cancel"
 S SDTMPX("DESCR",3)="tele health appointments in VistA. TMP needs to"
 S SDTMPX("DESCR",4)="be kept up to date with appointments are"
 S SDTMPX("DESCR",5)="cancelled by other applications in order to be"
 S SDTMPX("DESCR",6)="able to accurately display open appointment"
 S SDTMPX("DESCR",7)="slots. This index will trigger an HL7 message"
 S SDTMPX("DESCR",8)="sent to TMP that will update the clinic's and "
 S SDTMPX("DESCR",9)="patient's appointments in the TMP database"
 S SDTMPX("DESCR",10)="system to reflect the cancellation."
 S SDTMPX("SET CONDITION")="S X=X1(1)="""""
 S SDTMPX("SET")="D EN^SDTMPHLA(DA(1),DA)"
 S SDTMPX("KILL")="Q"
 ;S SDTMPX("WHOLE KILL")="Q"
 S SDTMPX("VAL",1)=3 ;Status
 D CREIXN^DDMOD(.SDTMPX,"",.SDTMPY) ;SDTMPY=ien^name of index
 I +$G(SDTMPY)>0 N IEN S IEN=+SDTMPY,^DD("IX",IEN,"NOREINDEX")=1
 Q
