GMTSP134 ;ISP/LMT - HEALTH SUMMARY Patch 134 Env Check and Post-Install ;Mar 09, 2020@12:01
 ;;2.7;Health Summary;**134**;Oct 20, 1995;Build 25
 ;
 ;
ENV ;
 ;check for and warn installer about duplicate Names or Abbreviations between local system and incoming national components (142.1)
 D INFO,CONT
 N GMTSITEM,GMTSINC,GMTSFLG,GMTSCONT,GMTSIEN S (GMTSITEM,GMTSINC)="",(GMTSFLG,GMTSCONT,GMTSIEN)=0
 F GMTSINC=1:1  S GMTSITEM=$P($T(ABV+GMTSINC),";",3),GMTSIEN=$P(GMTSITEM,U,2),GMTSITEM=$P(GMTSITEM,U) Q:GMTSITEM="EOF"  D
 .Q:$D(^GMT(142.1,"C",GMTSITEM))&(GMTSIEN=+$O(^GMT(142.1,"C",GMTSITEM,"")))  ;for test sites & multiple installs
 .I $D(^GMT(142.1,"C",GMTSITEM)) D  ;report conflict if abbreviation found
 .. W !,"CONFLICT: "_GMTSITEM_" is an existing ABBREVIATION for IEN "_+$O(^GMT(142.1,"C",GMTSITEM,""))
 ..S GMTSFLG=1
 S (GMTSITEM,GMTSINC)="",GMTSCONT=0
 F GMTSINC=1:1  S GMTSITEM=$P($T(NAME+GMTSINC),";",3),GMTSIEN=$P(GMTSITEM,U,2),GMTSITEM=$P(GMTSITEM,U) Q:GMTSITEM="EOF"  D
 .Q:$D(^GMT(142.1,"B",GMTSITEM))&(GMTSIEN=+$O(^GMT(142.1,"B",GMTSITEM,"")))  ;for test sites & multiple installs
 .I $D(^GMT(142.1,"B",GMTSITEM)) D  ;report conflict if name found
 ..W !,"CONFLICT: "_GMTSITEM_" is an existing NAME for IEN "_+$O(^GMT(142.1,"B",GMTSITEM,""))
 ..S GMTSFLG=1
 S:GMTSFLG GMTSCONT=$$OW
 W:$G(GMTSCONT)=1 !,"OK - Install will continue"
 I GMTSFLG=0,GMTSCONT=0 D
 .W !,"Environment check complete. No conflicts found."
 Q
INFO ; info
 W !,"New Health Summary Component (#142.1) entries will be installed by this"
 W !,"patch. NAME (.01) and ABBREVIATION (4) values should be unique throughout"
 W !,"this file. Any conflicts found will be written to the screen and you will"
 W !,"have the choice to continue with installation or abort. Conflicts do not"
 W !,"prevent you from installing, but should be addressed soon after install.",!
 Q
CONT() ; -- read output before continuing
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FO",DIR("A")="<Enter> to continue"
 D ^DIR
 Q
OW() ;ASK THE USER TO CONTINUE WITH INSTALLATION
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!,"Installation *may* continue, but you must record these conflicts and"
 W !,"pass along to the appropriate site resource for review and edit of"
 W !,"local/existing items.",!
 S DIR(0)="Y^",DIR("A")="Do you wish to proceed with installation of this patch",DIR("B")="NO"
 D ^DIR
 W !
 S:+$G(Y)=0 XPDQUIT=2
 Q:$G(XPDQUIT)=2 +$G(Y)
 Q +$G(Y)
ABV ;abbreviations
 ;;PMPA^271
 ;;EOF
NAME ;names
 ;;PDMP AOD ALL^271
 ;;EOF
 ;
 ;
POST ; Post-Install
 D CI
 Q
 ;
 ;
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 N INCLUDE
 S GMTSCPS="PMPA"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 I $G(GMTSTOT)>0 S INCLUDE=+$G(XPDQUES("POS1")) D ENPOST^GMTSLOAD
 D LIM
 I $L($T(SEND^GMTSXPS1)) D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*134" D SEND^GMTSXPS1
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))
 . S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
 ;
PMPA ; PDMP AoD All Component Data
 ;0;;271
 ;.01;;PDMP AOD ALL
 ;1;;PDMPAODA;GMTSORPD
 ;1.1;;0
 ;2;;Y
 ;3;;PMPA
 ;3.5;;9
 ;3.5;1;This component lists the PDMP Accounting of Disclosures for instances
 ;3.5;2;where a PDMP query was initiated from within CPRS and patient's data was
 ;3.5;3;shared outside of the VA. It will also include cases where a PDMP
 ;3.5;4;note was manually created to document a PDMP query made directly on a
 ;3.5;5;state's PDMP portal.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;PDMP AoD All
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;TIM;;1Y
 ;
 Q
 ;
