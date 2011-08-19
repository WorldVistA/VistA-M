DVBHQM2 ;ISC-ALBANY/PKE - MAIL DELIVERY PROGRAM;6/10/09 6:01pm
 ;;4.0;HINQ;**49,63,65**;03/25/92;Build 19
 G EN
LIN S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") Q
 ;
EN ;P&T now sent by VBA, 2=no, 3=yes, else null
 I $D(DVBPTI),((DVBPTI=2)!(DVBPTI=3)) S DVBPTI=$S(DVBPTI=2:"No",DVBPTI=3:"Yes",1:""),T1="    Perm.,Total Disability = "_DVBPTI D LIN
 ;DVB*4*65
 I $D(DVBPTI),($G(DVBPTIDT)>0) S M=$E(DVBPTIDT,1,2) D MM^DVBHQM11 S T1="    Perm.,Total Disability Eff Date = "_M_" "_$S(+$E(DVBPTIDT,3,4)>0:$E(DVBPTIDT,3,4)_", ",1:" ")_$E(DVBPTIDT,5,8) D LIN
 I $D(DVBAAHB),((DVBAAHB="A")!(DVBAAHB="H")) S Y=DVBAAHB S Y=$S(Y="A":"A&A Paid",Y="H":"Housebound Paid",1:"") S T1="             AID & ATTEND = "_Y D LIN
 I $D(DVBFIDUC),(DVBFIDUC>0) S T1="Chief Attorney, fiduciary = "_DVBFIDUC D LIN
 ;;;I $D(DVBFIDUC),DVBFIDUC,$D(^DIC(4,DVBFIDUC,0)) S DVBFIDUC=$P(^(0),U),T1="Chief Attorney, fiduciary = "_DVBFIDUC D LIN
 ;VBA field is Unemployable, codes will Y=Unemploy, N=Employ DVB*4*49 
 I $D(DVBEI),((DVBEI="N")!(DVBEI="Y")) S DVBEI=$S(DVBEI="N":"Employable or not an issue",DVBEI="Y":"Unemployable",1:""),T1="     Employable indicator = "_DVBEI D LIN
 ;new VBA codes, I=incompetent or C=competent DVB*4*49
 I $D(DVBCI),((DVBCI'=" ")) S DVBCI=$S(DVBCI=1!(DVBCI="C"):"Competent, or not an issue",DVBCI="I"!(DVBCI="2"):"Incompetent",1:DVBCI),T1="     Competency indicator = "_DVBCI D LIN
 ;Severence Recoup, PFOP, Competency Pay Status  and Consol Payment will
 ;no longer be sent by VBA - DVB*4*49
 ;DVB*4*65
 I $D(DVBDENTI),((DVBDENTI'=" ")) S DVBDENTI=$S(DVBDENTI="Y":"    Dental Treatment provided at discharge",DVBDENTI="N":"    No dental treatment at discharge",1:DVBDENTI),T1=DVBDENTI D LIN
 ;
 I $D(DVBP(2)) D P2^DVBHQM11
PNX I $D(DVBSPNAM),DVBSPNAM'?10" " S T1=" " D LIN S T1="Spouse name = "_DVBSPNAM D SDB,LIN
 S T1="" D LIN
 S T1="          "
 ;CHAMPVA no longer sent by VBA - DVB*4*49
 K C I $D(DVBBAS(1)) F N=32:1:35 I $P(DVBBAS(1),U,N) D SHDR Q
 I $D(C) D COUNT ;DVB*4*49 - some fields for C not sent by VBA any more
 ;so calculate from Child Status field
 I $D(C) D LIN S T1="",$P(T1,"-",80)="" D LIN S T1="School = "_$P(C,U,3)_"   Helpless School = "_$P(C,U,4)_"   Depend. total = "_$$DEP($P(C,U,1))_"   This Award = "_$$DEP($P(C,U,2)) D LIN
 I '$D(C),T1'["Not" S T1=$E(T1,1,23) D LIN
 K C
 I $D(DVBCHILD) S T1="" D LIN S T1="Child name        DOB       Child Status" D LIN
 I $D(DVBCHILD) F DVBC=0:0 S DVBC=$O(DVBCHILD(DVBC)) Q:'DVBC  S DVBDOB=$P(DVBCHILD(DVBC),U,3),V=$P(DVBCHILD(DVBC),U),T1=$P(DVBCHILD(DVBC),U,2) D CDATE,CHILD D
 . F DVBB=$L(T1):1:10 S T1=T1_" "
 . S T1=T1_"   "_$E(Y_" ",1,11)_"   "_V D LIN
 K DVBPSNAM,DVBSPDOB,DVBCHILD,DVBDOB,V
 ;
 ;-8
 ;with DVB*4*49 Hardship Exp no longer sent by VBA, so removed from line
 S T1=" " D LIN
 S T1="Check Amount= '''                Net Award= '''"
 I $D(DVBBAS(1)) S $P(T1,"'",5,6)="$"_$P(DVBBAS(1),U,20)
 I $D(DVBCHECK) S $P(T1,"'",2,3)="$"_DVBCHECK
 ;I $P(^DIC(8,$P(^DPT(DFN,.36),U),0),U)'="NSC" D LIN
 D LIN
 K DVBCAP
 ;
RINC ;
 I $G(DVBINC)]"" I +$P(DVBINC,U,15)>0 S T1="                Income for VA Purposes= '$"_$P(DVBINC,U,15)_".00'" D LIN
 ;
EX ;
 K C,T2,T1,DVBDXPCT,DVBPT,DVBPTI,DVBPTIDT,DVBDENTI,DVBAAHB,DVBFIDUC,DVBEI,DVBCI,DVBCPS,DVBSPNAM,DVBSPDOB,DVBCHILD,DVBDOB,V,DVBCHECK,Y
 D ADD^DVBHQM31
 G ERR^DVBHQM3 ;with DVB*4*49 no call made to EN^DVBHQM3
 ;
SHDR S T1=T1_"             Number of CHILDREN"
 I N>31 S C=$P(DVBBAS(1),U,32,35) Q
 ;
RHDR S T1="" D LIN
 S T1="last date    previously    INCOME REPORTED              amount, type" D LIN
 S T1="Reported     Reported    This Year   For VA purposes   Medical or Last Expense" D LIN
 S T1="",$P(T1,"-",80)="" D LIN Q
 ;
FILLER S T1="" F N=14,12,13,15,16,17 I N'=16 S T2=$S(N'=14:"$",1:"")_+$P(DVBINC,U,N),T1=T1_$J(T2,6) S:N<16 T1=T1_"       " I N=17 S T2=$P(DVBINC,U,16) D RTYP S T1=T1_" "_T2 D LIN S T1="" D LIN
 Q
 ;
RTYP S T2=$S(T2=" ":T2,T2="B":"SS/Other",T2="C":"Unusual Med.Exp.",T2="O":"Other",T2="R":"10%Ret.Pay excl.",T2="S":"Social Security",1:"") Q
 ;
AAA S V=Y S:Y>3&(Y<8) V=Y-4 S V=$S(V=0:"HB and/or A&A TERM",V=1:"HOSPITALIZED, HB,A&A PAY",V=2:"PAY A&A",V=3:"HB ONLY ",V=" ":"HB and/or A&A NOT GRANTED",1:"") I +Y,Y>3&(Y<8) S Y=V_", INCREMENT FOR SPOUSE" Q
 S Y=V Q
 ;
CHILD Q:$G(V)'?1U  S V=$S(V="H":"Helpless Child",V="M":"Minor Child",V="N":"Not an award dep.",V="S":"School Child",V="U":"Unclaimed DIC Child",1:"")
 Q
 ;
CPS S Y=$S(Y=1:"Competent,or not an issue,Pay direct",Y=2:"Incompetent by VA, Court .. pay fiduciary",Y=3:"Incompetent by Court, .. pay fiduciary",Y=4:"Competent by Court, Incompetent by VA .. pay direct",Y=5:"Supervised direct pay",1:Y) Q
 ;
SDB I $D(DVBSPDOB),DVBSPDOB I DVBSPDOB?8N S M=$E(DVBSPDOB,1,2) D MM^DVBHQM11 S T1=T1_"    DOB = "_M_" "_$S(+$E(DVBSPDOB,3,4)>0:$E(DVBSPDOB,3,4)_", ",1:" ")_$E(DVBSPDOB,5,8) K M
 Q
 ;
CDATE I DVBDOB'?8N S Y="" Q
 ;change CDATE to receive date as MMDDYYYY - DVB*4*49
 ;change to take in an eight digit date - DVB*4*63
 S M=$E(DVBDOB,1,2) D MM^DVBHQM11
 S Y=M_" "_$S(+$E(DVBDOB,3,4)>0:$E(DVBDOB,3,4)_",",1:" ")_$E(DVBDOB,5,8)
 Q
DEP(X) ;;V-S^V-S-F^V-S-M^V-S-2P^V-F^V-M^V-2P^V^
 ;Dependency codes
 Q:X>89 X Q:X'?2N X
 I X="00" S X="V" Q X
 I X="80" S X="V-C" Q X
 I $E(X,2)=0 S X=$P($P($T(DEP),";;",2),"^",$E(X,1)) Q X
 I X?2N S X=$P($P($T(DEP),";;",2),"^",$E(X,1))_"-"_$E(X,2)_"C" Q X
 Q X
COUNT ;loop through the DVBCHILD array and count the total, helpless and 
 ;school children
 N DVBC,DVBH,DVBS,DVBT
 S (DVBC,DVBH,DVBS,DVBT)=0
 F  S DVBC=$O(DVBCHILD(DVBC)) Q:DVBC'>0  D
 . I $P(DVBCHILD(DVBC),U)="H" S DVBH=DVBH+1
 . I $P(DVBCHILD(DVBC),U)="S" S DVBS=DVBS+1
 . S DVBT=DVBT+1
 S C=DVBT_"^"_+$P(C,U,2)_"^"_DVBS_"^"_DVBH
 Q
