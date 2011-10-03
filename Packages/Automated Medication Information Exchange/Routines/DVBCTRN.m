DVBCTRN ;ALB/JLU;This is an integration routine;5/18/92
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN2(DVBCROT,DVBCPAK,DVBCSFT,DVBCPHY,DVBCDTE) ;
 ;This entry point will first check to see if the soft link is valid
 ;if so then it will down load the information to AMIE.
 ;DVBCROT -  This is the variable root (local or global) that is 
 ;           currently holding the information to be down loaded.
 ;           It should not contain any parenthesis. Ex. JJ OR ^JJ
 ;DVBCPAK -  This is the name of the package that is using this entry
 ;           point.
 ;DVBCSFT -  This is the soft link
 ;DVBCPHY -  This is a pointer to the New Person file of the physican who
 ;           performed the exam.
 ;DVBCDTE -  This is the date the exam was performed.  It must be in
 ;           FM format.
 ;
 ;all must be defined in order for this entry except DVBCDTE and DVBCPHY
 ;point to be used.
 ;** Even though this entry point checks to see if the request and exam
 ;can still receive data, it should not be used in place of EN1 for this
 ;type of checking.
 ;
 N DVBCAGL1,DVBCAGL,DVBCFN2,DVBCFN3,DVBCX,DVBCNNUM,DVBEST,DVBAGL,DVBCST,DVBCST1,DVBX,DVBCST2,DVBCHK,DVBC,DVBCFN1,DVBCDT,DVBCRT1,DVBCRT2
 I $S('$D(DVBCROT):1,DVBCROT']"":1,1:0) Q "-1^Global root not defined or is null"
 I $S('$D(DVBCPAK):1,DVBCPAK']"":1,1:0) Q "-2^Sending package name not defined or is null"
 I $S('$D(DVBCSFT):1,DVBCSFT']"":1,1:0) Q "-3^Soft link not defined or is null"
 ;I $S('$D(DVBCDTE):1,DVBCDTE']"":1,1:0) Q "-3^Date of exam not defined."
 ;I $S('$D(DVBCPHY):1,DVBCPHY']"":1,1:0) Q "-3^Physician is not defined."
 ;I $D(DVBCPHY),($S(DVBCPHY']"":1,'$D(^VA(200,DVBCPHY,0)):1,1:0)) Q "-9^Check New Person file pointer value."
 S DVBCPHY=$S('$D(DVBCPHY):"",DVBCPHY']"":"",$D(^VA(200,DVBCPHY,0)):$P(^(0),U,1),1:"")
 I $D(DVBCDTE),(DVBCDTE'?7N0.1".".N) Q "-10^Check exam date."
 I '$D(DVBCDTE) S DVBCDTE=""
 ;
 D SFT
 I $P(DVBCHK,"^",1)<0 Q DVBCHK
 S DVBCAGL=DVBCFN3_DVBEST_",""RES"")"
 I '$D(@DVBCAGL@(0)) S ^(0)="^^0^0^"_DT_"^^^^"
 S DVBCST=$P(^(0),"^",3)+1 ;naked references the I '$D above.
 S DVBCST1=0
 S Y=DT D DD^%DT S DVBCDT=Y
 K Y
 F DVBX=1:1:3 S @DVBCAGL@(DVBCST,0)=$S(DVBX=2:"** "_DVBCPAK_" / "_DVBCDT_" **",1:" "),DVBCST=DVBCST+1,DVBCST1=DVBCST1+1
 S DVBCST2=""
 F DVBCST=DVBCST:1 S DVBCST2=$O(@DVBCROT@(DVBCST2)) Q:DVBCST2=""  S @DVBCAGL@(DVBCST,0)=@DVBCROT@(DVBCST2),DVBCST1=DVBCST1+1
 S DVBCST=DVBCST-1
 S DVBCST1=DVBCST1+$P(@DVBCAGL@(0),"^",4)
 S $P(@DVBCAGL@(0),"^",1,5)="^^"_DVBCST_"^"_DVBCST1_"^"_DT
 ;setting physican and date
 S DIE="^DVB(396.4,",DA=DVBEST
 S DR=".04///C;.06////"_DVBCDTE_";.07////"_DVBCPHY
 D ^DIE
 K DA,DIE,DR
 Q "1^Down load of transcription complete"
 ;
 ;
EN1(DVBCDFN,DVBCXM,DVBCSFT) ;
 ;This entry point is used to 1) acquire the soft link information and
 ;2) verify the availability of the soft link's request at a latter date.
 ;DVBCDFN -  This is the DFN of the Patient the exam was or is to be
 ;performed on.
 ;DVBCXM -  This is the name of the exam.  A search of file 396.6 will
 ;be done to see if this exam exists.
 ;DVBCSFT -  This is the soft link that the calling program wants
 ;verified.  DVBCSFT need only be defined if a soft link is known and
 ;someone wishes to verify its availability.
 ;
 N DVBC,DVBCDFN1,DVBEST,DVBCFN1,DVBCFN2,DVBCFN3,DVBCHK,DVBCORQ,DVBCOXM,DVBCROT,DVBCST,DVBCST1,DVBCST2,DVBCX,DVBCXM1,DVBCRT1,DVBCRT2,DVBJ
 I $D(DVBCSFT) D SFT
 I '$D(DVBCSFT) D NSFT^DVBCTRN1
 Q DVBCHK
 ;
SFT S DVBC=$P(DVBCSFT,";",1)
 S DVBCFN1=$P(DVBC,":",1)
 I 'DVBCFN1!('$D(^DIC(DVBCFN1,0,"GL"))) S DVBCHK="-1^File number of soft link is bad" Q
 I DVBCFN1'=396.3 S DVBCHK="-1.5^File number of soft link is incorrect." Q
 ;naked references ^dic(dvbcfn1,0,"gl") on line before
 S DVBCFN2=^("GL")
 S DVBCX=$P(DVBC,":",2)
 I DVBCX'?1.9N S DVBCHK="-2^Entry number in soft link is bad" Q
 S DVBCFN3=$P(DVBC,":",3)
 I 'DVBCFN3!('$D(^DIC(DVBCFN3,0,"GL"))) S DVBCHK="-3^Second file number in soft link is bad" Q
 I DVBCFN3'=396.4 S DVBCHK="-3.5^Second file number in soft link is incorrect." Q
 ;naked reference from ^dic(dvbcfn3,0,"gl")
 S DVBCFN3=^("GL")
 S DVBEST=$P(DVBC,":",4)
 I DVBEST'?1.9N S DVBCHK="-4^2507 Exam entry number in soft link is bad" Q
 S DVBCRT1=DVBCFN2_DVBCX_")"
 I '$D(@DVBCRT1@(0)) S DVBCHK="-5^This request nolonger exists" Q
 ;naked references indirected gloabal on line before
 I '$$OREQ^DVBCTRN1($P(^(0),"^",18)) S DVBCHK="-6^This request is nolonger open" Q
 S DVBCRT2=DVBCFN3_DVBEST_")"
 I '$D(@DVBCRT2@(0)) S DVBCHK="-7^Exam nolonger exists." Q
 ;naked references indirected global on line before
 I "OC"'[$P(^(0),"^",4) S DVBCHK="-8^Exam can nolonger accept data" Q
 I $P(^(0),"^",2)'=DVBCX S DVBCHK="-9^This exam does not belong to the proper request." Q
 S DVBCHK="1^Entry can still receive data"
 Q
