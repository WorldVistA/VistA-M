XUMF5I ;ISS/PAVEL - XUMF5 MD5 Hash Entry point ;5/19/06  06:15
 ;;8.0;KERNEL;**383,407**;July 10, 1995;Build 8
 ;
 ;MD5 based on info from 4.005 SORT BY VUID
 ;
 Q
EN(X0,MODE,IENCOUNT)  ;entry point to get MD5 algorithm
 ; Lookup uses AMASTERVUID for files and B x-ref for subfiles....
 ;
 ; X0 = IEN or name of entry from 4.005 file
 ; MODE = 0 regular mode.. last HASH value returned in Apl. ACK.
 ;        1 debugging mode.. all values + hash codess returned in Apl ACK
 ;        1.1 debugging mode.. all values (no hash codes) returned in Apl ACK
 ;        2 debugging mode.. all fields values, all hash values, all hash codes returned in Apl. ACK.
 ; IENCOUNT  = maximum entries for MD5 hash.. if NULL.. all entries counted...        
 ;
 ; TMP(sequence, def entry IEN, file/subfile #, field #)=""
 ; TMP1(,"1,120.82,2,",2)="INTERNAL"
 ; TMP2(FILE #,FIELD #)=""  if internal value requested...
 N X,Y,X1,X2,X3,X20,X201,X1NEW,X2NEW,X2OLD,X0NAME,XP,H,CNT,CNTT,CNHT,XMD5,XDATE,XXP
 N DIC,ERR,ROOT,ROOTX,ROOTB,ROOTB0,POINTER,JUMP,START,TMP,TMP1,TMP2,TMP3,TMP4,TMP5,TMP6,TMP7,FDA,VERSION
 N SLEV,LEV,IENS,VAL,VALUE,SORT,SORT1,EXITMD5
 N A,B,C,D,ABCD
 D INIT^XUMF5II S X1=0
2 F  S X1=$O(TMP(X1)) Q:'$$NEXTB1(LEV)!EXITMD5  S:'X1 X1=SLEV(LEV),X2OLD=0  S X2=$O(TMP(X1,X0,0)) Q:'X2  D
 .S (XP,JUMP)=0,XXP=$O(TMP(X1,X0,X2,0))
 .;************ File/subfile has changed ************
 .D:X2'=X2OLD
 ..;K ^TMP("UNIQUE",$J)
 ..;
 ..;************ File Level & Start ************
 ..I $D(^DIC(X2)),START D  Q
 ...S START=0,SLEV(1)=X1,X2OLD(1)=X2
 ...K ROOT,ROOTB,ROOTB0,X02,X021,TMP1
 ...S LEV=1,IENS=""
 ...D GETONE(LEV,X2)
 ..;
 ..;************ Going Up ************
 ..I $G(^DD(X2OLD,0,"UP"))=X2 D  Q
 ...K ^TMP("UNIQUE",$J,X2OLD)
 ...I $$NEXTB(LEV,X2OLD) S JUMP=2 Q
 ...K ROOT(LEV),ROOTB(LEV),ROOTB0(LEV),X20(LEV),X201(LEV),TMP1(LEV),X2OLD(LEV)
 ...S LEV=LEV-1,IENS=$P(IENS,",",$L(IENS,",")-LEV,9999),X2=X2OLD(LEV)
 ..Q:JUMP
 ..;
 ..;************ Going DOWN ************
 ..I $G(^DD(X2,0,"UP"))=X2OLD D  Q
 ...S LEV=LEV+1,SLEV(LEV)=X1,X2OLD(LEV)=X2
 ...D GETONE(LEV,X2)
 ..;
 ..;************ Same Level other multiple... ************
 ..I $G(^DD(X2,0,"UP"))=$G(^DD(X2OLD,0,"UP")),+$G(^DD(X2OLD,0,"UP")),+$G(^DD(X2,0,"UP")) D  Q
 ...I $$NEXTB(LEV,X2OLD) S JUMP=2 Q
 ...K ROOT(LEV),ROOTB(LEV),ROOTB0(LEV),X20(LEV),X201(LEV),TMP1(LEV),X2OLD(LEV)
 ...S IENS=$P(IENS,",",$L(IENS,",")-LEV+1,9999) ;B:'$L(IENS)
 ...S SLEV(LEV)=X1
 ...S X2OLD(LEV)=X2
 ...;S X2=X2OLD
 ...D GETONE(LEV,X2)
 ..Q:JUMP
 ..;
 ..;************ New File not start... ************
 ..I $D(^DIC(X2)) D  Q
 ...S:'$D(X2NEW) X2NEW=X2,X1NEW=X1
 ...I $$NEXTB(LEV,X2OLD(LEV)) S JUMP=2 Q
 ...K ROOT(LEV),ROOTB(LEV),ROOTB0(LEV),X20(LEV),X201(LEV),TMP1(LEV),SLEV(LEV),X2OLD(LEV)
 ...S IENS=$P(IENS,",",$L(IENS,",")-LEV+1,9999) ;B:'$L(IENS)
 ...I LEV=1 S (X1,SLEV(1))=X1NEW,(X2,X2OLD(1))=X2NEW K X1NEW,X2NEW D GETONE(LEV,X2) Q  ;;;;;;;;GET TO THE BOTTOM LEVEL = 1 NOT ANY OTHRER'S B X-REF
 ...S LEV=LEV-1,X1=SLEV(LEV)-1,X2=+$G(X2OLD(LEV-1)),XP=1
 ..;
 ..;************ Last sequence number ************
 ..I X2OLD=0 D  Q
21 ...I $$NEXTB(LEV,X2) S JUMP=2 Q
 ...K ROOT(LEV),ROOTB(LEV),ROOTB0(LEV),X20(LEV),X201(LEV),TMP1(LEV),X2OLD(LEV)
 ...Q:LEV=1
 ...S LEV=LEV-1,IENS=$P(IENS,",",$L(IENS,",")-LEV,9999),X2=X2OLD(LEV) ;,X1=SLEV(LEV)-1,XP=1
 ...G 21
 ..Q
 ..;
 .S X2OLD=X2
 .Q:JUMP
 .;************ Get value & MD5 ************
 .S X3=$O(TMP(X1+XP,X0,X2,0)) Q:'X3
 .S VAL=$S($L(IENS):$G(TMP1(LEV,X2,IENS,X3)),1:"")
 .Q:'$L(VAL)
 .D:$O(TMP1(LEV,X2,IENS,X3,0))
 ..N X4 S X4=0,VAL="" F  S X4=$O(TMP1(LEV,X2,IENS,X3,X4)) Q:'X4  S VAL=VAL_$G(TMP1(LEV,X2,IENS,X3,X4))
 .;If value set as uniqueue and already exist dont take it into MD5
 .Q:'$L(VAL)
 .I $G(TMP5(X2,X3)) Q:$D(^TMP("UNIQUE",$J,X2,X3,VAL))  S ^TMP("UNIQUE",$J,X2,X3,VAL)=""
 .D
 ..N X,TMP,I
 ..I X3=99.99,$D(^DIC(X2)) S CNTT=CNTT+1 I $G(IENCOUNT),CNTT>IENCOUNT S EXITMD5=1,CNTT=CNTT-1 Q
 ..D:MODE>1.99 SETACK("File #: "_X2_" Field #: "_X3_" Value: "_VAL_" IENS: "_IENS)
 ..S CNT=$G(CNT)+1
 ..S VALUE=VALUE_VAL
211 ..Q:$L(VALUE)<65
 ..S X=$E(VALUE,65,$L(VALUE)),VALUE=$E(VALUE,1,64)
 ..D:MODE
 ...D SETACK($S(MODE=1.1:"",1:"Value: ")_VALUE)
 ...D:MODE'=1.1 SETACK("HASH:  "_$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5E^XUMF5AU(ABCD,VALUE,0,CNHT+1*64))))
 ..S ABCD=$$MD5E^XUMF5AU(ABCD,VALUE,1)
 ..S VALUE=X,CNHT=CNHT+1
 ..G 211
 .Q
 G END^XUMF5II
 Q
GETONE(LEV,X2)     ;GET DATA
 S ROOT(LEV)=$$ROOT^DILFD(X2,"1,"_IENS,,"ERR")
 Q:'$L(ROOT(LEV))
 I $D(ERR) D  Q
 .S ERROR="1^MD5 ROOT retrieval error, File/Subfile #: "_X2_" IENS: 1,"_IENS,EXITMD5=1,JUMP=2
 .D EM^XUMFX("file DIE call error message in RDT",.ERR)
 .K ERR
 S ROOTX(LEV)=ROOT(LEV)_"X201(LEV))" ;FOR LOOKUP OF ENTRIES
 S SORT1="",SORT="B" S:$D(^DIC(X2)) SORT="AMASTERVUID",SORT1="1,"
 S ROOTB(LEV)=ROOT(LEV)_""""_SORT_""",X20(LEV))"
 S X20(LEV)="",ROOTB0(LEV)=ROOT(LEV)_""""_SORT_""",X20(LEV),"_SORT1_"X201(LEV))"
 S:SORT="B" POINTER=$G(TMP7(X2,XXP)) ;Pointer = pointer to file #
 I SORT="B",+POINTER D  ;Handle poiter type of subfile...
 .N BB S POINTER=$E(POINTER,2,$L(POINTER))
 .; ^TMP("PROOT",$J,Subfile #,IEN from up level,"Name sorted",IEN level)=""
 .; ^TMP("PROOT",$J,Subfile #,IEN from up level,X20(LEV),X201(LEV))=""
 .K ^TMP("PROOT",$J,X2)
 .;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .S X201(LEV)=0 F  S X201(LEV)=$O(@(ROOTX(LEV)))  Q:'X201(LEV)  D
 ..I $G(TMP4(X2,XXP)) D  ; If  sort By VUID
 ...S BB=$$GET1^DIQ(X2,X201(LEV)_","_IENS,XXP,"I")     ;BB=IEN of poited to field
 ...S:BB BB=$$GET1^DIQ(TMP4(X2,XXP),BB_",",99.99,"E")  ;BB=VUID
 ..E  S BB=$$GET1^DIQ(X2,X201(LEV)_","_IENS,XXP,"E")   ; Else sort by .01    BB= .01
 ..S:$L(BB) ^TMP("PROOT",$J,X2,BB,X201(LEV))=""
 .;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .S ROOTB(LEV)="^TMP(""PROOT"",$J,"_X2_",X20(LEV))"
 .S ROOTB0(LEV)="^TMP(""PROOT"",$J,"_X2_",X20(LEV),X201(LEV))"
 I SORT="B",LEV=2,X2=+$P(^DD(X2OLD(1),99.991,0),U,2) D  ;Handle Effective Date/Status multiple... only last date taken to HASH... TERMSTATUS
 .K ^TMP("PROOT",$J,X2)
 .S X20(LEV)=$O(@(ROOTB(LEV)),-1) ;Get last date..
 .Q:'$L(X20(LEV))  ;No Data in Effective Date Multiple.
 .S X201(LEV)=0,X201(LEV)=+$O(@ROOTB0(LEV))
 .Q:'X201(LEV)
 .S ROOTB(LEV)="^TMP(""PROOT"",$J,"_X2_",X20(LEV))"
 .S ROOTB0(LEV)="^TMP(""PROOT"",$J,"_X2_",X20(LEV),X201(LEV))"
 .S ^TMP("PROOT",$J,X2,X20(LEV),X201(LEV))=""
 S X20(LEV)=""
GET1 S X20(LEV)=$O(@(ROOTB(LEV))) Q:'$L(X20(LEV))  S X201(LEV)=0,X201(LEV)=$O(@(ROOTB0(LEV)))
 I $D(^DIC(X2)),'$$ACTIVE(X2,X201(LEV)_","_IENS) G GET1 ;If not active entry.. skip it..
 S IENS=X201(LEV)_","_IENS
 Q:'X201(LEV)
 D GETSIE(X2,IENS,LEV)
 Q
NEXTB(LEV,X2X)      ;Get next IEN from xref on current level.. if exist
 ;Is there other entry at current level to be proceeded..  ?? get next "B" x-ref set old X2 = NEW X2 and go to loop
 Q:'$D(X20(LEV)) 0
N1 Q:'$L(X20(LEV)) 0
 Q:'($O(@(ROOTB0(LEV)))!$L($O(@(ROOTB(LEV))))) 0
 S:X201(LEV) X201(LEV)=$O(@(ROOTB0(LEV))) ;Try get new IEN fron B-xref
 I 'X201(LEV) S X20(LEV)=$O(@(ROOTB(LEV))),X201(LEV)=0 S:$L(X20(LEV)) X201(LEV)=$O(@(ROOTB0(LEV)))
 Q:'X201(LEV) 0
 I $D(^DIC(X2X)),'$$ACTIVE(X2X,X201(LEV)_","_$P(IENS,",",2,99)) G N1 ;If not active entry.. skip it..
 S $P(IENS,",",1)=X201(LEV)
 S X2=X2X
 D GETSIE(X2,IENS,LEV)
 S X1=SLEV(LEV)-1,XP=1
 Q 1
NEXTB1(LEV)     ;See if some other entries in x-ref at any level exist...  no variable is set.
 ;
 Q:X1 1
3 Q:LEV=0 0
 I LEV>1,'$L($G(X20(LEV))) G 4
 I LEV=1,'$L($G(X20(LEV))) Q 0
 I LEV=1,'($O(@(ROOTB0(LEV)))!$L($O(@(ROOTB(LEV))))) Q 0
 I LEV=1,'$$ACTALL() Q 0
 I X201(LEV),$O(@(ROOTB0(LEV))) Q 1
 Q:$L($O(@(ROOTB(LEV)))) 1 ;
 Q:LEV=1 0
4 S LEV=LEV-1 G 3
 Q
SETACK(X,MODE)      ;SET APPL. Acknowledgment + WRIGHT ?? 
 W X,!
 S:$G(MODE) ^TMP("XUMF ERROR",$J,XMD5,$O(^TMP("XUMF ERROR",$J,XMD5,9999999999999),-1)+1)=X
 Q
UP(X) ;Upercase conversion    
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
ACTIVE(FILE,IEN)        ;GET 1 = Active 0 = Inactive
 N TMP,BB,X,X1,X2,XT,XX
 D GETS^DIQ(FILE,IEN,"99.991*","I","TMP","ERR")
 S (XT,XX)=0,X="TMP"
 F  S X=$Q(@(X)) Q:'$L(X)  S X1=$G(@(X)),X=$Q(@(X)),X2=$G(@(X)) S:X1>XT XT=X1,XX=+X2
 Q XX
GETSIE(X2,IENS,LEV)     ;GET Internal/External values + replace pointed field .01 with VUID
 K TMP1(LEV) D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 D:$D(TMP2(X2))!$D(TMP4(X2))
 .N TMP3,I
 .D GETS^DIQ(X2,IENS,"*","I","TMP3")
 .S I="" F  S I=$O(TMP2(X2,I)) Q:'I  S:$D(TMP1(LEV,X2,IENS,I)) TMP1(LEV,X2,IENS,I)=TMP3(X2,IENS,I,"I")
 .;+++++++++++++++ Replace pointed .01 field with VUID if indicate so in 4.005
 .S I="" F  S I=$O(TMP4(X2,I)) Q:'I  S:$D(TMP1(LEV,X2,IENS,I)) TMP1(LEV,X2,IENS,I)=$$GET1^DIQ(TMP4(X2,I),TMP3(X2,IENS,I,"I")_",",99.99)
 Q
ACTALL() ;See if there is some active entry on the file....
 N X1,X2,ACT
 S ACT=0,X1=X20(1),X2=X201(1)
 S:X20(1) X20(1)=X20(1)-.01
 F  S X20(1)=$O(@(ROOTB(1))) Q:'X20(1)!ACT  F  S X201(1)=$O(@(ROOTB0(1))) Q:'X201(1)  I $$ACTIVE(X2OLD(1),X201(1)) S ACT=1 Q
 S X20(1)=X1,X201(1)=X2
 Q ACT
 Q
