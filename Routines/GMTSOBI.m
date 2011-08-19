GMTSOBI ; SLC/KER - HS Object - Import/Install    ; 01/06/2003
 ;;2.7;Health Summary;**58,89**;Oct 20, 1995;Build 61
 ;                      
 ; External References
 ;   DBIA 10096  ^%ZOSF("DEL"
 ;   DBIA 10013  IX1^DIK
 ;   DBIA 10112  $$SITE^VASITE
 ;   DBIA  2055  $$FLDNUM^DILFD (file 142.5)
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10013  ^DIK
 ;                        
EN ; Install Object from Routine GMTSOBX
 N DA,DIK,GMTS3,GMTS4,GMTSC,GMTSEDAT,GMTSETYP,GMTSETTL,GMTSDAO
 N GMTSDAT,GMTSDR,GMTSEX,GMTSFAC,GMTSFRM,GMTSI,GMTSIEN,GMTSIT
 N GMTSL,GMTSLN,GMTSNDD,GMTSOBJ,GMTSOBX,GMTSON,GMTSQIT,GMTSR
 N GMTSROK,GMTSRT,GMTSRTN,GMTST,GMTSTE,GMTSTN,GMTSTMP,GMTSTR
 N GMTSTTL,GMTSTXT,GMTSTYP,GMTSUSR,X
 I +($$FLDNUM^DILFD(142.5,"NAME"))'>0!('$D(^GMT(142.5))) D  Q
 . W !," Unable to find HEALTH SUMMARY OBJECTS file #142.5"
 S GMTSEDAT=0,GMTSRTN="GMTSOBX",GMTSQIT=0,GMTSUSR=+($G(DUZ)) I +GMTSUSR=0 W !!," User not defined" Q
 I +($$ROK^GMTSOBU(GMTSRTN))'>0 W !," Error:",!,"    Object not Found (routine GMTSOBX)" Q
 F GMTSI=1:1:7 D
 . S GMTST=$$TX^GMTSOBU(GMTSRTN,GMTSRTN,(GMTSI-1)) S:GMTST["Object:  " GMTSOBJ=$P(GMTST,"Object:  ",2)
 . S:GMTST["From:    " GMTSFRM=$P(GMTST,"From:    ",2) S:GMTST["Sender:  " GMTSDR=$P(GMTST,"Sender:  ",2)
 S (GMTSON,GMTSOBJ)=$P($$TX^GMTSOBU(GMTSRTN,"OBJ",1),";",2)
 S (GMTSTN,GMTSTYP)=$P($$TX^GMTSOBU(GMTSRTN,"TYPE",1),";",2)
 I GMTSOBJ=""!(GMTSFRM="")!(GMTSDR="") W !," Error:",!,"    Can not install object from ",GMTSRTN Q
 W !," Installing Health Summary Object:  ",GMTSOBJ
 I $L(GMTSTYP) D
 . W !,"        Using Health Summary Type:  ",GMTSTYP
 W !,"                             From:  ",GMTSFRM
 W !,"                           Sender:  ",GMTSDR
 S GMTSTTL=$P($$TX^GMTSOBU(GMTSRTN,"TYPE",2),";",2)
 ;   Check Facility
 S GMTSFAC=+($P($$SITE^VASITE,"^",3)) I +GMTSFAC=0 W !," Error:",!,"    Facility not defined" Q
 ;   Check Object
 W !!," Checking Health Summary Object file #142.5"
 I $L(GMTSOBJ) D  Q:GMTSQIT
 . N GMTSTMP S GMTSTMP=$$BOX^GMTSOBU(GMTSOBJ) I +($G(GMTSTMP))>0 W ! D ER1^GMTSOBU S GMTSQIT=1
 ;   Check Type
 W !," Check Health Summary Type file #142"
 I $L(GMTSTYP) D  Q:GMTSQIT
 . S GMTSQIT=1 N GMTSTMP S GMTSTMP=$$NWX^GMTSOBU(GMTSTYP)
 . S:+($G(GMTSTMP))'>0 GMTSQIT=0 I +($G(GMTSTMP))>0 D
 . . S GMTSEDAT=$$EHST^GMTSOBU I GMTSEDAT>0 D  Q
 . . . S GMTSDAT=GMTSEDAT,GMTSQIT=0 I $L($G(GMTSETYP)),$L($G(GMTSETTL)) D
 . . . . S GMTSTYP=GMTSETYP,GMTSTTL=GMTSETTL
 ;   Check Title
 W !," Checking for Duplicate Title"
 I $L(GMTSTTL) D  Q:GMTSQIT
 . N GMTSTMP S GMTSTMP=$$TWX^GMTSOBU(GMTSTTL) I +GMTSTMP>0 W ! D ER3^GMTSOBU S GMTSQIT=1
 S GMTSDAT=$$TIEN^GMTSOBU S:+($G(GMTSEDAT))>0 GMTSDAT=+($G(GMTSEDAT))
 S:GMTSDAT'>0 GMTSQIT=1
 I GMTSQIT W !," Unable to add Health Summary Type" Q
 S GMTSDAO=$$OIEN^GMTSOBU(GMTSFAC) S:GMTSDAO'>0 GMTSQIT=1
 I GMTSQIT W !," Unable to add Health Summary Object" Q
 L +^GMT(142,+GMTSDAT):0 S:'$T GMTSQIT=1
 L +^GMT(142.5,+GMTSDAO):0 S:'$T GMTSQIT=1
 I +($G(GMTSQIT))>0 L -^GMT(142,+GMTSDAT) L -^GMT(142,+GMTSDAO) D  Q
 . W !," Unable to add Health Summary Type and Object"
 I GMTSDAT>0,GMTSDAO>0,GMTSQIT'>0 D HST,HSO
 D DELERR L -^GMT(142,+GMTSDAT) L -^GMT(142,+GMTSDAO)
 D DONE W !
 Q
HST ; Install Health Summary Type
 ;   Needs GMTSRTN, GMTSDAT, GMTSUSR, GMTSTYP, GMTSTTL
 Q:+($G(GMTSTE))>0  N GMTSROK,GMTSI,GMTSTXT,GMTSTR,GMTSNDD,GMTSR,GMTSC,GMTSRT,GMTS3,GMTS4,DA,DIK
 Q:+($G(GMTSQIT))>0  S GMTSQIT=0,GMTSROK=$$ROK^GMTSOBU(GMTSRTN) Q:GMTSROK'>0
 ;   Save Type
 I '$L(GMTSTYP)!('$L(GMTSTTL)) S GMTSQIT=1 Q
 F GMTSI=3:1 Q:GMTSQIT  D  Q:GMTSQIT
 . S GMTSTXT=$$TX^GMTSOBU(GMTSRTN,"TYPE",GMTSI),GMTSTXT=$P(GMTSTXT," ;",2,299)
 . I '$L(GMTSTXT) S GMTSQIT=1 Q
 . S GMTSTR=$P(GMTSTXT,";",1),GMTSNDD=$P(GMTSTXT,";",2)
 . S GMTSR=$P(GMTSTR,",",2),GMTSC=$P(GMTSNDD,"^",2)
 . Q:GMTSR>0&(GMTSC>0)&('$D(^GMT(142.1,+GMTSC)))  Q:(GMTSR>0)&(GMTSC>0)&(GMTSC>999)
 . S:GMTSTR="0" $P(GMTSNDD,"^",3)=GMTSUSR
 . S:GMTSTR="0"&($L(GMTSTYP)) $P(GMTSNDD,"^",1)=GMTSTYP
 . S:GMTSTR="""T"""&($L(GMTSTTL)) $P(GMTSNDD,"^",1)=GMTSTTL
 . S GMTSNDD=$TR(GMTSNDD,"""","") S:'$L(GMTSNDD) GMTSNDD=""""""
 . S GMTSRT="^GMT(142,DA,"_GMTSTR_")"
 . S DA=GMTSDAT S @GMTSRT=GMTSNDD
 ;   Check Indexes
 S GMTSQIT=0 F GMTSI="B","C" S GMTSR=0 F  S GMTSR=$O(^GMT(142,GMTSDAT,1,GMTSI,GMTSR)) Q:+GMTSR=0  D
 . S GMTSC=0 F  S GMTSC=$O(^GMT(142,GMTSDAT,1,GMTSI,GMTSR,GMTSC)) Q:+GMTSC=0  D
 . . I '$D(^GMT(142,GMTSDAT,1,GMTSC)) K ^GMT(142,GMTSDAT,1,GMTSI,GMTSR,GMTSC)
 ;   Re-Index
 S DA=GMTSDAT,DIK="^GMT(142," D IX1^DIK
 ;   Check Structure (sub-file 142.01)
 S (GMTSI,GMTS3,GMTS4)=0 F  S GMTSI=$O(^GMT(142,GMTSDAT,1,GMTSI)) Q:+GMTSI=0  D
 . S GMTS3=GMTSI,GMTS4=GMTS4+1
 S:GMTS3>0&(GMTS4>0)&($D(^GMT(142,GMTSDAT,1,0))) ^GMT(142,+GMTSDAT,1,0)="^142.01IA^"_GMTS3_"^"_GMTS4
 Q
HSO ; Install Health Summary Object
 ;   Needs GMTSRTN, GMTSDAO,GMTSUSR
 Q:+($G(GMTSQIT))>0  N GMTSQIT,GMTSROK,GMTSTXT,GMTSOBJ,GMTSNDD,GMTSTR,GMTSRT,DA,DIK
 S GMTSQIT=0,GMTSROK=$$ROK^GMTSOBU(GMTSRTN) Q:GMTSROK'>0
 S GMTSTXT=$$TX^GMTSOBU(GMTSRTN,"OBJ",1),GMTSOBJ=$P(GMTSTXT,";",2,299)
 S GMTSTXT=$$TX^GMTSOBU(GMTSRTN,"OBJ",2),$P(GMTSTXT,"^",17)=GMTSUSR,GMTSNDD=GMTSTXT
 S GMTSTR=$P(GMTSNDD,";",2),GMTSNDD=$P(GMTSNDD,";",3,299)
 S GMTSRT="^GMT(142.5,DA,"_GMTSTR_")",DA=GMTSDAO,DIK="^GMT(142.5,"
 S $P(GMTSNDD,"^",3)=+($G(GMTSDAT)),$P(GMTSNDD,"^",17)=+($G(GMTSUSR))
 S $P(GMTSNDD,"^",18)=$$NOW^XLFDT H 1 S $P(GMTSNDD,"^",19)=$$NOW^XLFDT
 S $P(GMTSNDD,"^",20)=0,@GMTSRT=GMTSNDD
 ;AGP CHANGE FOR NEW SUBSCRIPT
 S GMTSTXT=$$TX^GMTSOBU(GMTSRTN,"OBJ",3),GMTSNDD=GMTSTXT
 S GMTSTR=$P(GMTSNDD,";",2),GMTSNDD=$P(GMTSNDD,";",3,299)
 S GMTSRT="^GMT(142.5,DA,"_GMTSTR_")"
 S @GMTSRT=GMTSNDD
 D IX1^DIK
 Q
DELERR ; Delete on Error
 I +($G(GMTSDAT))>0,+($G(GMTSDAO))'>0 D
 . D DI(+($G(GMTSDAT)),"^GMT(142,")
 . W !," An error has occurred while installing Health Summary Object"
 . W !," Deleting the associated Health Summary Type"
 I +($G(GMTSDAT))'>0,+($G(GMTSDAO))>0 D
 . D DI(+($G(GMTSDAO)),"^GMT(142.5,")
 . W !," An error has occurred while installing Health Summary Type"
 . W !," Deleting the associated Health Summary Object"
 I +($G(GMTSDAT))>0&('$D(^GMT(142,+GMTSDAT))) D
 . D DI(+($G(GMTSDAT)),"^GMT(142,"),DEL(+($G(GMTSDAO)),"^GMT(142.5,")
 . W !," An error has occurred while installing Health Summary Type"
 . W !," Deleting the associated Health Summary Object"
 I +($G(GMTSDAO))>0&('$D(^GMT(142.5,+GMTSDAO))) D
 . D DI(+($G(GMTSDAT)),"^GMT(142,"),DEL(+($G(GMTSDAO)),"^GMT(142.5,")
 . W !," An error has occurred while installing Health Summary Object"
 . W !," Deleting the associated Health Summary Type"
 Q
DI(X,Y) ; Delete Item
 N DA,DIK S DA=+($G(X)),DIK=$G(Y) D:$L(DIK) ^DIK
 Q
DONE ; Completed
 I +($G(GMTSDAT))>0,+($G(GMTSDAO))>0 D
 . I $D(^GMT(142,+GMTSDAT,0)),$D(^GMT(142.5,+GMTSDAO,0)) D
 . . H 1 I $L(GMTSTN),$L(GMTSON) D  Q
 . . . W !!," Object '",GMTSON,"' installed using Health Summary Type '",GMTSTN,"'"
 . . W !," Object Installed"
 ;AGP ADDED TO CLEAN-UP ROUTINE GMTSOBX
 D DEL(GMTSRTN)
 Q
DEL(X) ;   Delete Routine X
 S X=$G(X) Q:'$L(X)  Q:$L(X)>8  Q:$$ROK^GMTSOBU(X)=0  X ^%ZOSF("DEL") Q
