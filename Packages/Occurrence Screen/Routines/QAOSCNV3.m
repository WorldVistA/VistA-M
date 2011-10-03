QAOSCNV3 ;HISC/DAD-ASSOCIATED ADMISSION, COMMENTS FIELDS & E XREF ;7/26/93  12:18
 ;;3.0;Occurrence Screen;;09/14/1993
 G:$O(^QA(741,0))'>0 EXIT
 W !!,"Load ASSOCIATED ADMISSION field,"
 W !,"convert COMMENTS to word processing"
 W !,"and, index the 'E' cross reference"
 W !,"-----------------------------------",!
 W !!?5,"The associated admission dates will now be calculated for all"
 W !?5,"Occurrence Screen records.  The data is saved in the ASSOCIATED"
 W !?5,"ADMISSION field (741,.02).  Depending on the number of"
 W !?5,"occurrences, this could take quite a while."
 W !!?5,"Also, the data in the COMMENTS fields in the REVIEWER and"
 W !?5,"COMMITTEE multiples (741.01,7 & 741.017,3) is copied to the"
 W !?5,"new word processing COMMENTS fields (741.01,10 & 741.017,10)."
 W !?5,"The old free text comments are deleted as they are converted."
 W !?5,"The 'E' cross reference on the OCCURRENCE IDENTIFIER field"
 W !?5,"(#741,2) will also be created."
 W !!,"Working" S QAORECRD=$G(QAORECRD) K ^QA(741,"E")
 F QAOSD0=0:0 S QAOSD0=$O(^QA(741,QAOSD0)) Q:QAOSD0'>0  D
 . W:QAORECRD#10'>0 "." S QAORECRD=QAORECRD+1
 . D AADM,REVR,CMTE
 . Q
EXIT ;
 K %,BEG,DA,DFN,DIE,DR,END,QAOSD0,QAOSD1,QAOSD2,QAOSDATE,QAOSDFN
 K QAOSTEXT,QAOSWORD,QAOSZERO,X,Y D KVAR^VADPT
 Q
AADM ; ASSOCIATED ADMISSION & 'E' XREF
 S QAOSZERO=$G(^QA(741,QAOSD0,0)) Q:QAOSZERO=""
 S X=$P(QAOSZERO,"^",4) S:X]"" ^QA(741,"E",$E(X,1,30),QAOSD0)=""
 Q:$P(QAOSZERO,"^",2)
 S QAOSDFN=+QAOSZERO,QAOSDATE=+$P(QAOSZERO,"^",3)
 Q:QAOSDATE'>0  Q:$D(^DPT(QAOSDFN,0))[0
 K VAIP S DFN=QAOSDFN,VAIP("D")=QAOSDATE\1,VAIP("M")=0 D IN5^VADPT
 I $D(^DGPM(+VAIP(1),0))#2,QAOSDATE\1'<(VAIP(3)\1) D
 . S DIE="^QA(741,",DR=".02///`"_+VAIP(1),DA=QAOSD0 D ^DIE
 . Q
 Q
REVR ; REVIEWER MULTIPLE
 F QAOSD1=0:0 S QAOSD1=$O(^QA(741,QAOSD0,"REVR",QAOSD1)) Q:QAOSD1'>0  D
 . S QAOSTEXT=$P($G(^QA(741,QAOSD0,"REVR",QAOSD1,0)),"^",7)
 . Q:QAOSTEXT=""  Q:$D(^QA(741,QAOSD0,"REVR",QAOSD1,3,0))#2
 . F QAOSD2=1:1 D  Q:QAOSTEXT=""
 .. S QAOSWORD=$L($E(QAOSTEXT,1,61)," "),X=$P(QAOSTEXT," ",1,QAOSWORD)
 .. S ^QA(741,QAOSD0,"REVR",QAOSD1,3,QAOSD2,0)=$$SPC(X)
 .. S QAOSTEXT=$P(QAOSTEXT," ",QAOSWORD+1,999)
 .. Q
 . S ^QA(741,QAOSD0,"REVR",QAOSD1,3,0)="^741.02^"_QAOSD2_"^"_QAOSD2
 . S $P(^QA(741,QAOSD0,"REVR",QAOSD1,0),"^",7)=""
 . Q
 Q
CMTE ; COMMITTEE MULTIPLE
 F QAOSD1=0:0 S QAOSD1=$O(^QA(741,QAOSD0,"CMTE",QAOSD1)) Q:QAOSD1'>0  D
 . S QAOSTEXT=$P($G(^QA(741,QAOSD0,"CMTE",QAOSD1,0)),"^",4)
 . Q:QAOSTEXT=""  Q:$D(^QA(741,QAOSD0,"CMTE",QAOSD1,1,0))#2
 . F QAOSD2=1:1 D  Q:QAOSTEXT=""
 .. S QAOSWORD=$L($E(QAOSTEXT,1,61)," "),X=$P(QAOSTEXT," ",1,QAOSWORD)
 .. S ^QA(741,QAOSD0,"CMTE",QAOSD1,1,QAOSD2,0)=$$SPC(X)
 .. S QAOSTEXT=$P(QAOSTEXT," ",QAOSWORD+1,999)
 .. Q
 . S ^QA(741,QAOSD0,"CMTE",QAOSD1,1,0)="^741.027^"_QAOSD2_"^"_QAOSD2
 . S $P(^QA(741,QAOSD0,"CMTE",QAOSD1,0),"^",4)=""
 . Q
 Q
SPC(X) ; REMOVE LEADING AND TRAILING SPACES
 N BEG,END
 F BEG=1:1 Q:$E(X,BEG)'=" "
 F END=$L(X):-1 Q:$E(X,END)'=" "
 Q $E(X,BEG,END)
