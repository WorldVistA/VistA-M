XDRDLIST ;SF-IRMFO/IHS/OHPRD/JCM - PRINT POTENTIAL AND VERIFIED DUPLICATES;    [ 08/13/92  09:50 AM ] ;8/28/08  18:13
 ;;7.3;TOOLKIT;**23,113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 N XDRFL,XDRFLD
START ;
 S XDRQFLG=0
 ; XT*7.3*113 input variable XDRNOPT to FILE^XDRDQUE-if UNDEF, allows PATIENT file to be selected
 N XDRNOPT
 ;W !!,"Choose type of list."
 S DIR("?")="BRIEF prints the fields: RECORD1, RECORD2 and the IEN for each entry.  CAPTIONED is FileMan's CAPTIONED format."
 S DIR("A")="Choose type of list",DIR(0)="SO^1:BRIEF;2:CAPTIONED" D ^DIR K DIR G:$D(DIRUT) END
 S XDRFLD=Y
 I '$D(XDRFL) S DIC("A")="Select File you wish to list for: " D FILE^XDRDQUE G:XDRQFLG END
 D ASK G:XDRQFLG END ; Asks which type of listing you want
 D @$S(XDRDLIST("ASK")=1:"POT",XDRDLIST("ASK")=2:"NOT",XDRDLIST("ASK")=3:"VER",1:"MERGED")
 G:'XDRQFLG START
END D EOJ ; End of job and cleans up variables
 Q  ; End of routine
 ;
ASK ;
 K XDRDLIST("ASK")
 S XDRDLIST("GL")=$S($D(^DIC(XDRFL,0,"GL")):$P(^DIC(XDRFL,0,"GL"),U,2),1:"")
 I XDRDLIST("GL")']"" S XDRQFLG=1 G ASKX
 W !!,"This utility provides reports on verified and unverified potential duplicates."
WHCH S DIR("A")="report",DIR(0)="SO^1:UNVERIFIED potential duplicates;2:NOT READY TO MERGE VERIFIED duplicates;3:READY TO MERGE VERIFIED duplicates;4:MERGED VERIFIED duplicates" D ^DIR K DIR
 I $D(DIRUT) S XDRQFLG=1 G ASKX
 I Y=" " S XDRQFLG=1 G ASKX
 S XDRDLIST("ASK")=$S(Y=1:1,Y=2:2,Y=3:3,1:4)
 I XDRDLIST("ASK")=1,'$D(^VA(15,"APOT",XDRDLIST("GL"))) W !,"There are no unverified potential duplicates at this time.",$C(7) K XDRDLIST("ASK") G WHCH
 I XDRDLIST("ASK")=3,'$D(^VA(15,"AMRG",XDRDLIST("GL"),1)) W !,"There are no READY TO MERGE verified duplicates at this time.",$C(7) K XDRDLIST("ASK") G WHCH
 I XDRDLIST("ASK")=2,'$D(^VA(15,"AMRG",XDRDLIST("GL"),0)) W !,"There are no NOT READY TO MERGE verified duplicates at this time.",$C(7) K XDRDLIST("ASK") G WHCH
 I XDRDLIST("ASK")=4,'$D(^VA(15,"AFR",XDRDLIST("GL"))) W !,"There are no MERGED VERIFIED duplicates at this time.",$C(7) K XDRDLIST("ASK") G WHCH
 ;
ASKX ;
 Q
 ;
POT ;
 S DIC="^VA(15,",L="",FLDS=$S(XDRFLD=1:"[XDR BRIEF LIST]",1:"[CAPTIONED]")
 S BY="[XDR POTENTIAL DUPLICATE LIST]"
 S DIS(0)="I $P($P(^VA(15,D0,0),U),"";"",2)=XDRDLIST(""GL"")"
 S DHD="Unverified Potential Duplicates"
 D EN1^DIP K DIC,DIS,DHD,L,FLDS,BY
 Q
 ;
VER ;
 S DIC="^VA(15,",L="",FLDS=$S(XDRFLD=1:"[XDR BRIEF LIST]",1:"[CAPTIONED]")
 ;S DIC="^VA(15,",L="",FLDS="[CAPTIONED]"
 S BY="[XDR READY TO MERGE LIST]"
 S DIS(0)="I $P($P(^VA(15,D0,0),U),"";"",2)=XDRDLIST(""GL"")"
 S DHD="Verified Duplicates Ready to Merge"
 D EN1^DIP K DIC,DIS,DHD,L,FLDS,BY
 Q
 ;
NOT ;
 S DIC="^VA(15,",L="",FLDS=$S(XDRFLD=1:"[XDR BRIEF LIST]",1:"[CAPTIONED]")
 ;S DIC="^VA(15,",L="",FLDS="[CAPTIONED]"
 S BY="[XDR NOT READY TO MERGE LIST]"
 S DIS(0)="I $P($P(^VA(15,D0,0),U),"";"",2)=XDRDLIST(""GL"")"
 S DHD="Verified Duplicates Not Ready to Merge"
 D EN1^DIP K DIC,DIS,DHD,L,FLDS,BY
 Q
MERGED ;
 S DIC="^VA(15,",L="",FLDS=$S(XDRFLD=1:"[XDR BRIEF LIST]",1:"[XDR MERGED LIST]")
 ;S DIC="^VA(15,",L="",FLDS="[XDR MERGED LIST]"
 S BY="[XDR MERGED LIST]"
 S DIS(0)="I $P($P(^VA(15,D0,0),U),"";"",2)=XDRDLIST(""GL"")"
 S DHD="Verified Duplicates that are Merged"
 D EN1^DIP K DIC,DIS,DHD,L,FLDS,BY
 Q
EOJ ;
 K XDRDLIST,DIRUT,X,Y,DTOUT,DUOUT,XDRD,XDRFL,XDRQFLG
 Q
