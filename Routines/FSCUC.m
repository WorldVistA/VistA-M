FSCUC ;SLC/STAFF-NOIS Utilities Count ;1/17/98  14:29
 ;;1.1;NOIS;;Sep 06, 1998
 ;
CALLNUM(SITE0,DATE,CALLREF,OK) ; from FSCELID, FSCRPCNC
 ; constructs call number from (site,date)
 N COUNT S OK=0
 S CALLREF=""
 I '$L(SITE0) Q
 I 'DATE Q
 D COUNT(DATE,.COUNT,.OK)
 I 'OK Q
 S CALLREF=$S($L($P(SITE0,U,3)):$P(SITE0,U,3),1:"ZZZ")_"-"_$E(DATE,4,5)_$E(DATE,2,3)_"-"_$S($P(SITE0,U,11):$P(SITE0,U,11),1:"N")_COUNT
 Q
 ;
COUNT(DATE,COUNT,OK) ;returns the next available counting number for
 N DA,DIK,NUM S OK=1
 S DATE=$E(DATE,1,5),NUM=+$O(^FSCD("COUNT","B",DATE,0))
 D
 .I 'NUM D  Q
 ..L +^FSCD("COUNT"):30 I '$T S OK=0 Q
 ..S COUNT=1,NUM=1+$P(^FSCD("COUNT",0),U,3)
 ..F  Q:'$D(^FSCD("COUNT",NUM))  S NUM=NUM+1
 ..S $P(^FSCD("COUNT",0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1,^(NUM,0)=DATE_U_1
 ..S DA=NUM,DIK="^FSCD(""COUNT""," D IX1^DIK
 ..L -^FSCD("COUNT")
 .L +^FSCD("COUNT",NUM):30 I '$T S OK=0 Q
 .S COUNT=$P(^FSCD("COUNT",NUM,0),U,2)+1,$P(^(0),U,2)=COUNT
 .L -^FSCD("COUNT",NUM)
 I 'OK Q
 S COUNT=$TR($J(COUNT,4)," ",0)
 Q
