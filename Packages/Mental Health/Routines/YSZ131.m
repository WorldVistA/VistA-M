YSZ131 ;SLC/GDU - PATCH YS*5.01*113 CODE; 3/24/14 15:32
 ;;5.01;MENTAL HEALTH;**131**;Dec 30, 1994;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Data Base Integration Agreement LIST
 ; EN^DDIOL            DBIA # 10142
 ; $$FIND1^DIC         DBIA # 2051
 ; FILE^DIE            DBIA # 2053
 ; GETS^DIQ            DBIA # 2056
 ; $$REPEAT^XLFSTR     DBIA # 10104
 ; ^XMD                DBIA # 10070
 ;Routine is to be called by entry point
 Q
 Q
EN ;Entry point
 D EN1,SMM,KYSV
 K YSCNT,YSFILE,YSMAIL,YSWAIT
 Q
EN1 ;R14616270FY17 - CIWA question number 11 for headache not totaling.
 S YSCNT=0,YSWAIT=1,YSFILE=601.91
 S YSMSG(1)="Patch YS*5.01*131 Installation Messages",YSMSG(1,"F")="!"
 S YSMSG(2)="R14616270FY17 - CIWA question number 11 for headache not totaling.",YSMSG(2,"F")="!"
 S YSMSG(3)="MH SCORING KEY records #6189 and #9587 have Target fields with an incorrect",YSMSG(3,"F")="!"
 S YSMSG(4)="value of 'Very Severe'. These records will be corrected with 'Very severe'.",YSMSG(4,"F")="!"
 D UM
 F YSIEN=6189,9587 D
 . S YSIENS=YSIEN_","
 . D GR I $D(YSFLD)=0 Q
 . ;If the value is already corrected, alert user and quit loop
 . I YSFLD(.01)=6189,YSFLD(3)="Very severe" D VAC,UM Q
 . I YSFLD(.01)=9587,YSFLD(3)="Very severe" D VAC,UM Q
 . ;Correct the value
 . I YSFLD(.01)=6189 S YSFDA(YSFILE,YSIENS,3)="Very severe" D VIC,FILE^DIE("","YSFDA","YSERR")
 . I YSFLD(.01)=9587 S YSFDA(YSFILE,YSIENS,3)="Very severe" D VIC,FILE^DIE("","YSFDA","YSERR")
 . I $D(YSERR) S YSERL=6 D PEM
 . D UM
 . K YSIENS,YSERR,YSFDA
 D KYSV
 Q
 ;
VAC ;Value Already Correct
 S YSMSG(5.1)="Value is already correct."
 S YSMSG(5.1,"F")="!?8"
 Q
 ;
VIC ;Value Is Corrected
 S YSMSG(5.1)="Value will be set to the correct value of "_YSFDA(YSFILE,YSIENS,3)
 S YSMSG(5.1,"F")="!?8"
 Q
 ;
GR ;Get Record
 I YSIEN="" Q
 K YSFLD
 D GETS^DIQ(YSFILE,YSIENS,"*","","YSREC","YSERR")
 I $D(YSERR) D PEM G GRQ
 M YSFLD=YSREC(YSFILE,YSIENS)
 S YSMSG(1)="MH SCORING KEY # "_YSFLD(.01)
 S YSMSG(1,"F")="!"
 S YSMSG(2)="Target: "_YSFLD(3)
 S YSMSG(2,"F")="!?4"
GRQ K YSERR,YSREC
 Q
 ;
PEM ;Process Error Message
 ;Add Error Text to User Message
 I '$D(YSERR) Q
 I '$D(YSERL) S YSERL=1
 S YSX=$P(YSERR("DIERR"),U)
 F YSX1=1:1:YSX D
 . S YSMSG(YSERL)="Error Code: "_YSERR("DIERR",YSX1)
 . S YSMSG(YSERL,"F")="!"
 . S YSX2=0
 . F  S YSX2=$O(YSERR("DIERR",YSX1,"TEXT",YSX2)) Q:YSX2=""  D
 . . S YSERL=YSERL+YSX2
 . . S YSMSG(YSERL)=YSERR("DIERR",YSX1,"TEXT",YSX2)
 . . S YSMSG(YSERL,"F")="!"
 K YSERL,YSERR,YSX,YSX1,YSX2
 Q
 ;
UM ;User Messages
 ;Display messages to the user
 D EN^DDIOL(.YSMSG)
 ;Build MailMan Message from user messages
 S YSX=0
 F   S YSX=$O(YSMSG(YSX)) Q:YSX=""  D
 . S YSX1=YSMSG(YSX)
 . I YSMSG(YSX,"F")="!!" S YSCNT=YSCNT+1,YSMAIL(YSCNT)=""
 . I YSMSG(YSX,"F")["?" D
 . . S YSX2=$$REPEAT^XLFSTR(" ",$P(YSMSG(YSX,"F"),"?",2))
 . . S YSX1=YSX2_YSX1
 . S YSCNT=YSCNT+1
 . S YSMAIL(YSCNT)=YSX1
 K YSMSG,YSX,YSX1,YSX2
 Q
 ;
SMM ;Send MailMan message to user
 N DIFROM,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S XMDUZ=.5
 S XMSUB=YSMAIL(1)
 S XMY(DUZ)=""
 S XMTEXT="YSMAIL("
 D ^XMD
 I '$D(XMMG) D EN^DDIOL("Report successfully sent.","","!!")
 Q
 ;
KYSV ;Kill YS Variables
 K YSACI,YSDEX,YSERR,YSFDA,YSFLD,YSFLG,YSIEN
 K YSIENS,YSML,YSMSG,YSREC,YSSCR,YSVAL
 Q
