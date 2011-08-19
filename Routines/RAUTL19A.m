RAUTL19A ;HISC/SWM-Utility Routine ;10/29/97  09:33
 ;;5.0;Radiology/Nuclear Medicine;**21**;Mar 16, 1998
 ;
CKOTHER(A) N E,J,I,RALERT,RAVER,RADETAIL,RAIMPRES,RASTNAM,RANODE,RAER1,RAVER1,RAIMPR1,RATICKET,RAVER2,RAIMPR2,RAPHY
 ;RAERR is used by RAUTL19 to signal one or more errors
 ;RAER1 stores 5 pieces of error flags for each imaging type :
 ;  pce 1=1 if more than 1 status has GENERATE EXAM ALERT? set to Y
 ;  pce 2=1 if verfd rpt req'd, but imprsn not req'd at same/lower status
 ;  pce 3=1 if detailed proc not req'd in any status
 ;  pce 4=1 if more than 1 status had PRINT DOSAGE TICKET? set to Y
 ;  pce 5=1 if staff/resident not req'd in any status
 ; only 1  'print dosage ticket'  allowed per imaging type
 ;
 S I=0,E="",RAER1="",RALERT=0,RATICKET=0
 S (RAVER1,RAVER2,RAIMPR1,RAIMPR2,RAPHY)=""
 F  S E=$O(^RA(72,"AA",A,E)) Q:E'=+E  D
 . S I=$O(^RA(72,"AA",A,E,0)) Q:'I
 . S RASTNAM=$P(^RA(72,I,0),U),RANODE(.1)=$G(^RA(72,I,.1))
 . S:$$UP^XLFSTR($G(^RA(72,I,"ALERT")))="Y" RALERT=RALERT+1,RALERT(E)=RASTNAM
 . S:$$UP^XLFSTR($P($G(^RA(72,I,.6)),U,11))="Y" RATICKET=RATICKET+1,RATICKET(E)=RASTNAM
 . S:$$UP^XLFSTR($P($G(^RA(72,I,.1)),U,3))="Y" RADETAIL(E)=""
 . S:$$UP^XLFSTR($P($G(^RA(72,I,.1)),U,2))="Y" RAPHY(E)=""
 . S RAIMPR1(E)=$P($G(^RA(72,I,.1)),U,16) ;actual value
 . S RAVER1(E)=$P($G(^RA(72,I,.1)),U,12)_U_RASTNAM ; actual value
 . S:$$UP^XLFSTR($P(RAVER1(E),U))="Y" RAVER2(E)=""
 . S:$$UP^XLFSTR($P(RAIMPR1(E),U))="Y" RAIMPR2(E)=""
 . Q
 S:RALERT>1 $P(RAER1,U)=1 S:RATICKET>1 $P(RAER1,U,4)=1
 S:$O(RAPHY(E))'>0 $P(RAER1,U,5)=1
 I $O(RAVER2(0))>0 D
 . I $O(RAIMPR2(0))>$O(RAVER2(0)) S $P(RAER1,U,2)=1
 . I $O(RAIMPR2(0))="" S $P(RAER1,U,2)=1
 . Q
 S E=""
 I '$O(RADETAIL(0)) S $P(RAER1,U,3)=1 ; ignore cancelled status
 Q:RAER1=""  S RAERR=1
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 I $P(RAER1,U)=1 D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!,RADASH,"Checking total number of alerts requested",RADASH,!?11,"within : ",A,!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"Statuses requesting '",$P(^DD(72,1,.1),U),"'"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . S I="" F  S I=$O(RALERT(I)) Q:I'=+I  W !?20,RALERT(I)
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?5,"There should be at most  1  status per imaging type where",!?5,"'",$P(^DD(72,1,.1),U),"' is Y."
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 I $P(RAER1,U,2)=1 D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!,RADASH,"Checking verified report required and impression required",RADASH,!?11,"within : ",A,!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"'",$P(^DD(72,.112,.1),U),"' was set to 'yes'; but",!?5,"'",$P(^DD(72,.116,.1),U),"' was not set to 'yes' at this and lower status(es) :",!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . S E="" W !?27,"Verified Rpt req'd",?53,"Impression Required"
 . F  S E=$O(RAVER1(E)) Q:E'=+E  W !?5,$P(RAVER1(E),U,2),?36,$P(RAVER1(E),U),?66,RAIMPR1(E) I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . Q:RAOUT
 . W !!?5,"If verified report is required at a particular status,",!?5,"then the impression should also be required at the same or lower status."
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 I $P(RAER1,U,3)=1 D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!,RADASH,"Checking presence of detailed procedure required",RADASH,!?11,"within : ",A,!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"None of the statuses requires detailed procedure.",!!?5,"A detailed procedure must be required in at least one status",!?5,"for PCE crediting."
 I $P(RAER1,U,5)=1 D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!,RADASH,"Checking presence of resident or staff required",RADASH,!?11,"within : ",A,!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"None of the statuses requires resident or staff.",!!?5,"Resident or staff must be required in at least one status",!?5,"for PCE crediting."
 I $P(RAER1,U,4)=1 D  Q:RAOUT
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!,RADASH,"Checking total number of print dosage ticket requested",RADASH,!?11,"within : ",A,!
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !?5,"Statuses requesting '",$P(^DD(72,.611,.1),U),"'"
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . S I="" F  S I=$O(RATICKET(I)) Q:I'=+I  W !?20,RATICKET(I)
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 . W !!?5,"There should be at most  1  status per imaging type, where",!?5,"'",$P(^DD(72,.611,.1),U),"' is Y."
 . I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 Q
