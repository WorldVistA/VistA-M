RASTREQ1 ;HISC/CAH,GJC AISC/MJK-Cont. of RASTREQ status reqmts ck ;5/29/97  12:52
 ;;5.0;Radiology/Nuclear Medicine;**34,85**;Mar 16, 1998;Build 4
 ;
 ; STUFF -- Called from UP1^RAUTL1 for editing an exam
 ; LOOP  -- Called from RASTREQ for status tracking
 ;             and from RASTREQ for cancel an exam
 ;
 ;Determine whether exam status can be updated to next higher status
 ;After this subrtn is executed, the following variables will exist:
 ;  RAOR= order seq no., = -1 if not eligible for an update
 ;  RASN= new status external format (or same status if not updateable)
 ;  RASTI= ien of new status if updateable
 ;This subrtn does not write any data to the status field, it only
 ;checks to see what the next status would be
 ;RABEFORE = status level BEFORE change
 ;RAAFTER = status level AFTER change
 ;
 ; 06/11/2007 BAY/KAM RA*5*85 Remedy Call 174790 Change exam cancel
 ;            to allow only descendent with stub/images
 ;
STUFF ; initialize RAOR=-1 to assume NO change if early quit
 S RAJ=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,0)),RAOR=-1
 S RABEFORE=$P($G(^RA(72,+$P(RAJ,U,3),0)),U,3)
 S RAORDIFN=+$P(RAJ,"^",11),RACS=$P(RAJ,"^",24),RAPRIT=$P(RAJ,"^",2)
 I $D(^RA(72,+$P(RAJ,"^",3),0)) S RASN=$P(^(0),"^") Q:$P(^(0),"^",3)'>0
 I $P(RAJ,"^",6)]"" S RAF5=$P(RAJ,"^",6)
 S RAIMGTYI=$P($G(^RADPT(DA(2),"DT",DA(1),0)),U,2),RAIMGTYJ=$P(^RA(79.2,RAIMGTYI,0),U)
 ; set RAOR, RASN, RASTI to lowest level's, to allow event when
 ; none of the levels meet all the requirements for that level
LOOP S RAOR=$S($O(^RA(72,"AA",RAIMGTYJ,0))>0:$O(^(0)),1:1)
 S RASTI=+$O(^RA(72,"AA",RAIMGTYJ,RAOR,0)),RASN=$P($G(^RA(72,+RASTI,0)),U)
 ;
 N RA
 F K=0:0 S K=$O(^RA(72,"AA",RAIMGTYJ,K)) Q:K'>0  D
 . S X="",E=+$O(^RA(72,"AA",RAIMGTYJ,K,0)) Q:E'>0
 . I $D(^RA(72,E,0)) D
 .. S RA(0)=$G(^RA(72,E,0)),N=$P(RA(0),"^"),RAS=$G(^RA(72,E,.1))
 .. I '$L(RAS) S RAS="N"
 .. D HELP1^RASTREQ I $D(X),K>RAOR S RAOR=K,RASTI=E,RASN=N
 .. Q
 . Q
 S RAAFTER=RAOR
 I $D(RASTI),RASTI=$P(RAJ,"^",3) S RAOR=-1
 K RAZ,RAK,RAE,RAIMGTYI,RAIMGTYJ,E,RAS,RAJ,RAJ1,N,K,FL
 Q
CANCEL ; cancel an exam
 S RAOR=0,RASTI=RAXX,RASN=$P($G(^RA(72,RAXX,0)),"^")
 S RAAFTER=RAOR
 Q:$D(RAOPT("DELETEXAM"))  ; 1st chk skip, 2nd chk done already<-- delxam
 ; check again: 'allow cancelling' and if report exists
 ; in case Fileman enter/edit was used directly on the EXAM STATUS field
 ; if either check fails, set RAAFTER=RABEFORE so status can't change
 I $D(^RA(72,+$P(RAJ,U,3),0)),$P(^(0),"^",6)'="y" W !,"This exam is in the '",$P(^(0),"^"),"' status and cannot be 'CANCELLED'" S RAAFTER=RABEFORE Q
 ; ok to cancel descendent exam w images if stub rpt and user has RA MGR key
 ; 06/11/2007 *85 Added descendent check to next line
 I $P(RAJ,U,17)'="",$$STUB^RAEDCN1($P(RAJ,U,17)),($$PSET^RAEDCN1(RADFN,RADTI,RACNI)),$D(^XUSEC("RA MGR",+$G(DUZ))) Q
 ; can't cancel exam if report isn't stub
 I $P(RAJ,U,17)'="" W !,"A report has been filed for this case.  Therefore cancellation is not allowed !" S RAAFTER=RABEFORE
 Q
