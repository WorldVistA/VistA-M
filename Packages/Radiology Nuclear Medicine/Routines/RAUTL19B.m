RAUTL19B ;HISC/SWM-Utility Routine ;10/29/97  09:29
 ;;5.0;Radiology/Nuclear Medicine;**10**;Mar 16, 1998
 ;
CKREQD(A) ;once a REQ'D fld is "Y", all higher status's same REQ'D fld must be "Y"
 N E,J,I,P,N,RA1,RASTNAM,RAER1,RAFLG,RAFLDNM,S,ARE
 ; RAERR is used by RAUTL19 to signal one or more errors
 S E=0,N=0
 ; E = order # of status progression
 ; I = ien of ^RA(72,)
 ; J = .1 or .5
 ; P = valid piece number from dd
 ; store .1 and .5 nodes for each given order # E
 F  S E=$O(^RA(72,"AA",A,E)) Q:E'>0  D
 . S I=$O(^RA(72,"AA",A,E,0)) Q:'I  S RA1(E,.1)=$S($G(^RA(72,I,.1))]"":^(.1),1:"")_"^/"_I,RA1(E,.5)=$S($G(^(.5))]"":^(.5),1:"")_"^/"_I
 . Q
 ; if a req'd fld = 'Y', then all higher statuses' same req'd fld = 'Y'
 ; raflg: 1 = a Yes has has been found on a status level for a field
 F J=.1,.5 S P=0 D
 . F  S P=$O(^DD(72,"GL",J,P)) Q:P'=+P  S E="",RAFLG=0 D
 .. F  S E=$O(RA1(E)) Q:E'=+E  D
 ... I RAFLG=0,$$UP^XLFSTR($P($P(RA1(E,J),"/"),U,P))="Y" S RAFLG=1 Q
 ... I RAFLG,$$UP^XLFSTR($P($P(RA1(E,J),"/"),U,P))'="Y" S RAER1(J,P,E)=$O(^DD(72,"GL",J,P,0)),N=N+1 ; set error to field number of file 72
 ... Q
 .. Q
 . Q
PRTREQD ;print any error messages on req'd flds
 Q:'$O(RAER1(0))
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!,RADASH,"Checking fields that have 'REQUIRED' in their name",RADASH,!?11,"within : ",A
 S RAERR=1,S=$S(N>1:"s",1:""),ARE=$S(N>1:"are",1:"is")
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!?5,"There ",ARE," ",N," error",S," found in REQUIRED fields.  The error",S
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !?5,ARE," due to 'Y' being answered at a lower status, and 'N' being"
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !?5,"answered at a higher status for the following prompts"
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!?5,"PROMPT",?55,"STATUS",?75,"DATA",!,?5,"------",?55,"------",?75,"----"
 F J=.1,.5 S P=0 D  Q:RAOUT
 . F  S P=$O(RAER1(J,P)) Q:P'=+P  D  Q:RAOUT
 .. I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 .. S RAFLDNM=$O(^DD(72,"GL",J,P,0)),RAFLDNM=$P(^DD(72,RAFLDNM,.1),U) S E=0 W !?5,"'",RAFLDNM,"'"
 .. F  S E=$O(RA1(E)) Q:E'=+E  I $G(RA1(E,J))]""  S RASTNAM=$P(^RA(72,$P(RA1(E,J),"/",2),0),U) W ?50,"(",E,")",?55,$E(RASTNAM,1,20),?77,$P($P(RA1(E,J),"/"),U,P),!
 .. Q
 . Q
 I 'RAOUT,$Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !!?5,"Once a data item is required, it should be required at all higher statuses."
 Q
CKCOMP(A) ; check COMPLETE status' reqd field not asked at COMPLETE
 ;         and field is asked at status where it's not reqd
 N E,RA1,RA2,RA3,I,N,P
 ; RA2() stores  not-required-but-aksed fields
 ; RA3() stores  required-but-not-asked fields, COMPLETE status only
 S E=0
CK2 S E=$O(^RA(72,"AA",A,E)) G:E'>0 CK9
 S I=$O(^RA(72,"AA",A,E,0)) G:'I CK2
 F N=.1,.2,.5,.6 S RA1(E,N)=$S($G(^RA(72,I,N))]"":^(N),1:"")
 ; .1 and .2 nodes
 F P=1,2,4,5,6,13,14 D
 . I $$UP^XLFSTR($P(RA1(E,.1),U,P))'="Y",$$UP^XLFSTR($P(RA1(E,.2),U,P))="Y" S RA2(E,.1,P)=I_U_$P(RA1(E,.1),U,P)_U_$P(RA1(E,.2),U,P) ; not req'd but asked
 . I E=9,$$UP^XLFSTR($P(RA1(E,.1),U,P))="Y",$$UP^XLFSTR($P(RA1(E,.2),U,P))'="Y" S RA3(.1,P)=I_U_$P(RA1(E,.1),U,P)_U_$P(RA1(E,.2),U,P) ; req'd but not asked, COMPLETE status only
 ; .5 and .6 nodes
 F P=1,3,4,5,8,9 D
 . I $$UP^XLFSTR($P(RA1(E,.5),U,P))'="Y",$$UP^XLFSTR($P(RA1(E,.6),U,P))="Y" S RA2(E,.5,P)=I_U_$P(RA1(E,.5),U,P)_U_$P(RA1(E,.6),U,P) ; not req'd but asked
 . I E=9,$$UP^XLFSTR($P(RA1(E,.5),U,P))="Y",$$UP^XLFSTR($P(RA1(E,.6),U,P))'="Y" S RA3(.5,P)=I_U_$P(RA1(E,.5),U,P)_U_$P(RA1(E,.6),U,P) ; req'd but not asked, COMPLETE status only
 G CK2
CK9 Q:'$D(RA2)  ; there's no NOT-REQUIRED-BUT-ASKED FIELD(S) AT ANY STATUS
 Q:'$D(RA3)  ; there's no REQ'D-BUT-NOT-ASKED FIELDS AT COMPLETE
 W !!,RADASH,"Warning on reaching Complete",RADASH,!?11,"within : ",A,!
 W !?5,"The following are permissible, but could lead to failure to"
 W !?5,"complete cases when prompts are not answered in lower status(es)."
 W !!?5,"STATUS",?20,"PROMPT",?70,"DATA",!?5,"------",?20,"------",?70,"------"
 G:'$D(RA2) CKWR7 S E=0
CKWR1 S E=$O(RA2(E)) G:'E CKWR7 S I=0
CKWR2 S I=$O(RA2(E,I)) G:'I CKWR1 S P=0
CKWR3 S P=$O(RA2(E,I,P)) G:'P CKWR2
 G:'$D(RA3(I,P)) CKWR3 ; skip if there's no problem with COMPLETE's
 S N=$O(^DD(72,"GL",I+.1,P,0)),N=$P(^DD(72,N,0),U)
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !?5,$P(^RA(72,+RA2(E,I,P),0),U),?20,N,?70,$P(RA2(E,I,P),U,3)
 S N=$O(^DD(72,"GL",I,P,0)),N=$P(^DD(72,N,0),U)
 W !?20,N,?70,$P(RA2(E,I,P),U,2),!
 G CKWR3
CKWR7 Q:'$D(RA3)  S I=0
CKWR8 S I=$O(RA3(I)) Q:'I  S P=0
CKWR9 S P=$O(RA3(I,P)) G:'P CKWR8
 S N=$O(^DD(72,"GL",I+.1,P,0)),N=$P(^DD(72,N,0),U)
 I $Y>(IOSL-6) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD^RAUTL11
 W !?5,$P(^RA(72,+RA3(I,P),0),U),?20,N,?70,$P(RA3(I,P),U,3)
 S N=$O(^DD(72,"GL",I,P,0)),N=$P(^DD(72,N,0),U)
 W !?20,N,?70,$P(RA3(I,P),U,2),!
 G CKWR9
