LRCKF68A ;DALOI/RWF/RLM-CHECK FILE 68 (CONT);8/27/87 10:32
 ;;5.2;LAB SERVICE;**272**;Sep 27, 1994
 ; Reference to CHK^DIE supported by IA #2053
 ; Reference to $$FMTE^XLFDT supported by IA #10103
 ; Reference to ^%ZOSF("TEST") supported by IA #10096
 ;
 Q  ;Continuation of LRCKF68
TESTV ; validation of data elements at TESTS multiple of ACCESSION NUMBER subfile
 I $D(^LAB(60,+LA4,0))[0 S E=5 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,4,TESTS,"68.04,.01")=">>FATAL<< - Invalid TEST pointer to LABORATORY TEST file (#60) found at TESTS multiple of the ACCESSION subfile. Entry: "_LRAN
 I $D(^LAB(62.05,+$P(LRSTR,U,2),0))[0 S E=6 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,4,TESTS,"68.04,1")=">>FATAL<< - Invalid URGENCY OF TEST pointer to URGENCY file (#62.05) found at TESTS multiple of the ACCESSION subfile. Entry: "_LRAN
 S Y=$P(LA4,U,3) Q:'+Y  S LRLL=+Y,LRTRAY=$P(Y,";",2),LRCUP=$P(Y,";",3),L=$S($D(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,0)):^(0),1:"")
 I LRWARN,L="" S E=9 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,4,TESTS,"68.04,2",1)=">>WARNING<< - Accession points to a load/work list entry that is missing"
 I LRWARN,$P(L,U,1,3)'=(LRAA_U_LRAD_U_LRAN) S E=10 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,4,TESTS,"68.04,2",2)=">>WARNING<< - Load/work list ("_LRLL_";"_LRTRAY_";"_LRCUP_") doesn't point back to here. ("_$P(L,U,1,3)_")"
 S WKLD=0 F  S WKLD=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,TESTS,1,WKLD)) Q:WKLD<1  I $D(^(WKLD,0))#2 S X=^(0) D
 . I $D(^LAM(+X,0))[0 S E=12 D NAME D
 . . S:E @LRTMPGL@(LRAA,LRAD,LRAN,4,TESTS,WKLD,"68.14,.01")=">>CRITICAL<< - Invalid WKLD CODE pointer to WKLD CODE file (#64) found at WKLD CODE multiple within the TEST multiple of the ACCESSION subfile. Entry: "_LRAN
 Q
 ;
SPECV ; validation of data elements at SPECIMEN multiple of ACCESSION NUMBER subfile
 I $D(^LAB(61,+LA5,0))[0 S E=7 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,5,SPEC,"68.05,.01")=">>FATAL<< - Invalid SPECIMEN pointer to the TOPOGRAPHY FIELD file (#61) found at SPECIMEN multiple of ACCESSION subfile.  Entry: "_LRAN
 I $D(^LAB(62,$P(LA5,U,2),0))[0 S E=8 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,5,SPEC,"68.05,1")=">>FATAL<< - Invalid COLLECTION SAMPLE pointer to COLLECTION SAMPLE file (#62) found at SPECIMEN multiple of ACCESSION subfile. Entry: "_LRAN
 S TEST=0 F  S TEST=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,SPEC,1,TEST)) Q:TEST<1  I $D(^(TEST,0))#2 S X=^(0) D
 . I $D(^LAB(60,+X,0))[0 S E=11 D NAME S:E @LRTMPGL@(LRAA,LRAD,LRAN,5,SPEC,TEST,"68.13,.01")=">>FATAL<< - Invalid TEST pointer to LABORATORY TEST file (#60) found at TEST multiple within the SPECIMEN multiple of ACCESSION subfile.  Entry: "_LRAN
 Q
 ;
INST ;
 I $D(^LAB(62.4,+LRSTR,0))[0 S @LRTMPGL@(LRAA,LRAD,LRACC,"68.09,.01")=">>FATAL<< - Invalid Instrumentation Controls pointer to the AUTO INSTRUMENT file (#62.4)."
 F LRCT=0:0 S LRCT=$O(^LRO(68,LRAA,.5,LRIN,1,LRCT)) Q:LRCT<1  I $D(^(LRCT,0))#2 S LRSTR=^(0) I $D(^LAB(62.3,+LRSTR,0))[0 S @LRTMPGL@(LRAA,LRAD,LRACC,68.1,"I"_LRCT)=">>FATAL<< - Invalid control name pointer to the CONTROL NAME file (#62.3)."
 Q
 ;
LABEL ; process numeric identifer and label fields
 S LRNID=$P(LRALE,U),LRALR=$P(LRALE,U,5),LRALE=$P(LRALE,U,4)
 S X="",DA=LRAA D CHK^DIE(68,.4,"E",LRNID,.X) I X="^" D
 . S @LRTMPGL@(LRAA,"68,.4")=">>CRITICAL<< - Invalid Numeric Identifer for record entry "_LRAA_": "
 . S @LRTMPGL@(LRAA,"68,.4",1)="Identifier has already been used in Accession Area: "_$P(LR0,U)
 I $L(LRALE),'$L(LRALR) S @LRTMPGL@(LRAA,LRAD,LRACC,"68,5.3")=">>FATAL<< - Alternate Label Entry field contains a value but the Alternate Label Routine field is missing the necessary routine name in order for the software to work." Q
 I $L(LRALR) S X=LRALR X ^%ZOSF("TEST") I '$T S @LRTMPGL@(LRAA,LRAD,LRACC,"68,5.3")=">>FATAL<< - INVALID routine name contained in the Alternate Label Routine field." Q
 I $L(LRALR),$L(LRALE) S LRALR=LRALE_U_LRALR I $T(@LRALR)']"" S @LRTMPGL@(LRAA,LRAD,LRACC,"68,5.3")=">>FATAL<< - INVALID label entry name contained in the Alternate Label Entry field."
 Q
 ;
NAME ;
 S E(8,E)=1+E(8,E) I E(8,E)>20 S E=0 Q
 I LRPWDT'=LRAD!(LRAA'=LRPWL) S @LRTMPGL@(LRAA,LRAD)="ACCESSION AREA: "_$P(^LRO(68,LRAA,0),U)_" for date: "_$$FMTE^XLFDT(LRAD,"") S LRPWL=LRAA,LRPWDT=LRAD
 I LRPACC'=LRACC S @LRTMPGL@(LRAA,LRAD,LRACC)="ACCESSION: "_LRACC S LRPACC=LRACC
 Q
