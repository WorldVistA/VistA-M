DGPMVBUR ;ALB/MIR - UR ADMISSION BULLETIN FOR MCCR ; 9/16/03 2:24pm
 ;;5.3;Registration;**26,31,483,549,570**;AUG 13, 1993
 ;
UR ;UR bulletin
 K DGPMUR
 D INS I '$D(DGPMUR(10)) D URQ Q
 S DGPMX=$O(^XMB(3.8,"B","DGPM UR ADMISSION",0)) I '$O(^XMB(3.8,+DGPMX,1,0)) K DGPMX D URQ Q  ; if no mailgroup members, quit
 S XMSUB="UR ADMISSION BULLETIN",XMTEXT="DGPMUR(",DGPMBLN=0
 S XMY("G.DGPM UR ADMISSION")="" ; pass mailgroup
 D PID^VADPT6 S DGPMBL="Admission for  : "_$P(^DPT(DFN,0),"^",1)_"   "_VA("PID") D SETLN
 S Y=+DGPMA X ^DD("DD") S DGPMBL="Date/Time      : "_Y D SETLN
 S DGPMBL="Type of Admit  : "_$S($D(^DG(405.1,+$P(DGPMA,"^",4),0)):$P(^(0),"^",1),1:"") D SETLN
 S DGPMBL=" " D SETLN
 S DGPMBL="Ward Location  : "_$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN") D SETLN
 S DGPMBL="Room-Bed       : "_$S($D(^DG(405.4,+$P(DGPMA,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN") D SETLN
 S DGPMBL="Admitting DX   : "_$P(DGPMA,"^",10) D SETLN
 S DGPMBL=" " D SETLN
 S DGPMBLN=DGPMLAST D V72HR  ; visits in last 72 hours
 D DIS ;SC disabilities
 D ^XMD
URQ K DGPMBL,DGPMBLN,DGPMLAST,DGPMUR,DGTMP,XMY,XMSUB,XMTEXT
 K %,%Y,DGPMOB,DGPMOW,DGPMX,I,X,X1,X2,Y,DGIBINS
 Q
 ;
INS ;get insurance effective at time of admission, start at DGPMBLN=10
 S DGPMBLN=9
 K DGIBINS
 N DGX,DGDATA,DGIB
 ;
 S DGIB=$$INSUR^IBBAPI(DFN,"","",.DGDATA,"*") ; Returns Active, Reimbursable Ins. only
 S DGX="DGDATA(""IBBAPI"",""INSUR"")" M DGIBINS=@DGX
 F I=0:0 S I=$O(DGIBINS(I)) Q:'I  D ACT
 ;
 I $D(DGPMUR(10)) S DGPMLAST=DGPMBLN
 Q
 ;
ACT ;is insurance active?  If so, set in DGPMBLN array
 I DGIBINS(I,11)<+DGPMA,DGIBINS(I,11)]"" Q  ;insurance expired before admission
 I DGIBINS(I,10)>+DGPMA Q  ;insurance effective after admission
 Q:'+DGIBINS(I,1)
 ; get insurance company information
 S DGPMBL="Insurance Co.  : "_$P(DGIBINS(I,1),"^",2) D SETLN
 S DGTMP=$P(DGIBINS(I,8),U,2)
 I DGTMP']"" S DGTMP=$S($G(DGIBNS(I,18))]"":DGIBINS(I,18),1:"")
 I DGTMP']"" S DGTMP=""
 I DGTMP]"" S DGPMBL="Group          : "_DGTMP D SETLN
 S DGPMBL="Policy Holder  : "_DGIBINS(I,13) D SETLN
 S DGPMBL="Subscriber ID  : "_DGIBINS(I,14) D SETLN
 S DGPMBL="Ins. Co Phone# : "_$S(DGIBINS(I,6)]"":DGIBINS(I,6),1:"UNKNOWN") D SETLN
 S DGPMBL=" " D SETLN
 Q
DIS ;rated disabilities
 I $S('$D(^DPT(DFN,.3)):1,$P(^(.3),"^",1)'="Y":1,1:"") Q  ;not service connected...
 I $S('$D(^DPT(DFN,"VET")):1,$P(^("VET"),"^",1)'="Y":1,1:0),$S('$D(^DG(391,+$S($D(^DPT(DFN,"TYPE")):^("TYPE"),1:""),0)):1,$P(^(0),"^",2):0,1:1) Q
 ;X=0 node, X1=already one SC disability?
 S X1=0 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  I $D(^(I,0)) S X=^(0) I $P(X,"^",3)&$D(^DIC(31,+X,0)) S DGPMBL=$S('X1:"SC Disabilities: ",1:"                 ")_$P(^(0),"^",1)_" ("_+$P(X,"^",2)_"%)" S X1=1 D SETLN
 Q
V72HR ; GET INFORMATION FROM VISITS FOR THE LAST 72 HOURS
 NEW X,X1,X2,IDEN,ID,LOCN,HSPN
 S X1=+DGPMA,X2=-3
 D C^%DTC
 S X=X-.0001
GVTIME ; LOOP THROUGH "B" INDEX OF ^AUPNVSIT FILE
 S X=$O(^AUPNVSIT("B",X))
 I X="" Q
 I X'<+DGPMA Q
 S IDEN=""
GVID ; CHECK FOR CORRECT PATIENT
 S IDEN=$O(^AUPNVSIT("B",X,IDEN))
 I IDEN="" G GVTIME
 I +$P($G(^AUPNVSIT(IDEN,0)),"^",5)'=+DFN G GVID
 S LOCN=$P(^AUPNVSIT(IDEN,0),"^",22)
 ; DG/549
 I $G(LOCN)>0 S HSPN=$P($G(^SC(LOCN,0)),"^",1)
 E  S HSPN="Unknown location" I $P($G(^AUPNVSIT(IDEN,0)),"^",7)="E" S HSPN=HSPN_"-Event(Historical)"
 ;
 S Y=+X X ^DD("DD")
 S DGPMBL="Previous Visit : "_HSPN_" "_Y
 D SETLN
 G GVID
 Q
SETLN ;--set line in xmtext array
 S DGPMBLN=DGPMBLN+1
 S DGPMUR(DGPMBLN)=DGPMBL
 Q
