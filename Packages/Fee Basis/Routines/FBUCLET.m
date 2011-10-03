FBUCLET ;ALBISC/TET - UNAUTHORIZED CLAIMS LETTER ;6/26/01
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
AUTO(FBDA,FBORDER,FBUCA,FBUC) ;auto print - called by update routine, tasked job
 ;INPUT:  FBDA = ien of unauthorized claim, file 162.7
 ;        FBORDER = (optional) order number of status
 ;        FBUCA = current (after) zero node of unauthorized claim (162.7)
 ;        FBUC = unauthorized claim node in parameter file
 ;OUTPUT: none - task q'd to print letter and update fields upon completion
 N ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE
 I $$PARAM(FBUC) S ZTIO=$P(FBUC,U,2) I ZTIO]"" D
 .S ZTRTN="AUTODQ^FBUCLET0",ZTDESC="AUTO PRINT UNAUTH CLAIM LETTER",ZTDTH=$H
 .S ZTSAVE("FBDA")="",ZTSAVE("FBORDER")="",ZTSAVE("FBUCA")="",ZTSAVE("FBUC")=""
 .D ^%ZTLOAD
 K IOP,ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTSK Q
 ;
PARAM(FBUC) ;check if letter should be printed
 ;check if parameter is set to print automatically, if so,
 ;check if printer is defined, if so ok to print
 ;INPUT:  FBUC = UC node (unauthorized claim node) of parameter file
 ;OUTPUT: 1 if ok to print letter, 0 if not ok
 Q $S($P(FBUC,U,3)'="A":0,$P(FBUC,U,2)']"":0,1:1)
 ;
PRFLD(FBDA) ;check if print field is still set
 ;INPUT:  FBDA = internal entry number of unauthorized claim (162.7)
 ;OUTPUT: 1 for ok to print, 0 to not print
 Q $S('$D(^FB583("AL",1,FBDA)):0,1:1)
 ;
REPRINT ;reprint
 N %ZIS,BEGDATE,ENDDATE,DIR,DIRUT,DTOUT,DUOUT,DISP,FBDT,FBI,FBJ,FBFR,FBNOUP,FBO,FBORDER,FBOUT,FBPL,FBPOP,FBRANGE,FBTO,FBUC,FBW,IOP,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 S FBOUT=0,FBUC=$$FBUC^FBUCUTL2(1)
 S DIR("A")="Do you wish to reprint letters for a date range",DIR(0)="Y",DIR("?")="Select Yes to reprint letters for a date range; No to reprint a specific letter."
 D ^DIR K DIR G END:$D(DIRUT),REPRINT:Y<0 S FBRANGE=Y I FBRANGE D DATE^FBAAUTL G:FBPOP END
 S FBFR=$S(FBRANGE:BEGDATE-.1,1:0),FBTO=$S(FBRANGE:ENDDATE,1:DT)
 I 'FBRANGE D LOOKUP^FBUCUTL3(0) G:FBOUT!('+$G(FBARY)) END I +$G(FBARY) S DISP=1 D PARSE^FBUCUTL4(FBARY),DISPY^FBUCUTL1 G:FBOUT!('+$G(FBARY(0))) END I $G(FBARY(0))]"" D STRING(FBARY(0))
 S DIR(0)="Y",DIR("A")="Should the expiration date be updated",DIR("B")="No",DIR("?")="Answer Yes to update the expiration date based upon today's printout, No to only reprint the letter but not change the date when the information is due."
 D ^DIR K DIR G END:$D(DIRUT),ASK:Y<0 S FBNOUP=$S('Y:1,1:0)
 D COPY G:FBOUT END S FBCOPIES=$S($P(FBUC,U,4):$P(FBUC,U,4),1:1)
 W ! S %ZIS("A")="Queue to print on: ",%ZIS("B")=$P(FBUC,U,2),%ZIS="NQ0",IOP="Q"_$S($P(FBUC,U,2):";"_$P(FBUC,U,2),1:"") D ^%ZIS G:POP END S $P(FBUC,U,2)=ION,ZTIO=ION,ZTDTH=$H
 S ZTRTN="REPRNTDQ^FBUCLET0",ZTDESC="REPRINT UNAUTH CLAIM LETTERS"
 S ZTSAVE("FBUC")="",ZTSAVE("FBFR")="",ZTSAVE("FBTO")="",ZTSAVE("FBNOUP")="",ZTSAVE("FBRANGE")="",ZTSAVE("FBARY(")="" I +$G(FBIEN) S ZTSAVE("FBIEN")="",ZTSAVE("FBIX")=""
 S:'$D(ZTDTH) ZTDTH=$H D ^%ZTLOAD
 K FBARY,^TMP("FBARY",$J),^TMP("FBARY",$J) G END
BATCH ;to batch print letters & update date letter printed, interactive
 N %ZIS,DIR,DIRUT,DTOUT,DUOUT,X,Y,FBOUT,FBUC,FBZ,IOP
 S FBOUT=0,FBUC=$$FBUC^FBUCUTL2(1)
ASK D COPY G:FBOUT END
 D LTRTYP G:FBOUT END
 W ! S %ZIS("A")="Queue to print on: ",%ZIS("B")=$P(FBUC,U,2),%ZIS="NQ0",IOP="Q"_$S($P(FBUC,U,2):";"_$P(FBUC,U,2),1:"") D ^%ZIS G:POP END S $P(FBUC,U,2)=ION,ZTIO=ION,ZTDTH=$H
 S FBCOPIES=$S($P(FBUC,U,4):$P(FBUC,U,4),1:1)
 ;call taskman queue
 S ZTRTN="BATCHDQ^FBUCLET0",ZTDESC="BATCH UNAUTH CLAIM LETTERS",ZTSAVE("FBUC")=FBUC,ZTSAVE("FBCOPIES")="",ZTSAVE("FBLTRTYP")="" S:'$D(ZTDTH) ZTDTH=$H  D ^%ZTLOAD
 ;G END
END D HOME^%ZIS K DA,DIE,DIRUT,DR,DTOUT,DUOUT,FBAR,FBARY,FBEXP,FBI,FBIEN,FBLET,FBLETDT,FBOUT,FBORDER,FBP,FBP,FBUC,FBCOPIES,FBDEVICE,POP,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTREQ,ZTSAVE,ZTSK,FBLTRTYP Q
COPY ;
 S DIR(0)="161.4,35O",DIR("A")="Enter NUMBER OF COPIES for each letter",DIR("B")=$P(FBUC,U,4) D ^DIR K DIR S:$D(DIRUT) FBOUT=1 G:+Y<0 COPY S $P(FBUC,U,4)=$S(+Y=0:1,1:+Y)
 Q
LTRTYP ; ask if user just want to print a specific letter type
 ;input - none
 ;output - FBLTRTYP - false if a specific letter type was not selected OR
 ;                    ien of the selected letter type (file #161.3)
 N DIR,DIC,Y
 S FBLTRTYP=""
 S DIR(0)="Y",DIR("A")="Print all types of letters",DIR("B")="YES"
 S DIR("?",1)="Enter YES to print all types of letters.  Enter NO to"
 S DIR("?",2)="just print letters of one specific type."
 S DIR("?",3)=" "
 S DIR("?")="Enter either 'Y' or 'N'."
 D ^DIR K DIR I $D(DIRUT) S FBOUT=1 Q
 I +Y S FBLTRTYP="A" Q
 S DIC=161.3,DIC(0)="AQEM",DIC("S")="I $P(^(0),U,2)=1"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) S FBOUT=1 Q
 I Y<0 G LTRTYP
 S FBLTRTYP=+Y
 Q
STRING(FBY) ;set variable to string of IEN's which user selected
 ;INPUT:  FBY = fbary(0) or what user selected
 ;OUTPUT: FBARY = count of what was selected
 ;        FBARY( = string array of selected IEN's of unauthorized claims,
 ;                  delimited by ','
 N FBCT,FBDCT,FBIEN,I
 S FBDCT=($L(FBY,","))-1,FBARY=FBDCT,FBCT=0 D CT
 F I=1:1:FBDCT I '($P(FBY,",",I)#1) S FBIEN=+$G(^TMP("FBARY",$J,$P(FBY,",",I))) D:($L(FBARY(FBCT)+FBIEN+1))>245 STRIP,CT S FBARY(FBCT)=FBARY(FBCT)_","_+$G(^TMP("FBARY",$J,$P(FBY,",",I)))
 D:$E(FBARY(FBCT),1)="," STRIP
 Q
CT ;counter
 ;INPUT:  FBCT = counter
 ;OUTPUT: FBCT incremented by one
 S FBCT=FBCT+1,FBARY(FBCT)=""
 Q
STRIP ;strip comma
 ;INPUT:  FBARY(FBCT array string
 ;OUTPUT: same array string with leading comma stripped
 S FBARY(FBCT)=$P(FBARY(FBCT),",",2,($L(FBARY(FBCT),",")))
 Q
