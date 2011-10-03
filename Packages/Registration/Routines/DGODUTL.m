DGODUTL ;ALB/EG - INITIALIZE ARRAYS FOR DGODNP1/DGODOP1 & TOTAL ; JAN-13-1989 @ 0854
 ;;5.3;Registration;;Aug 13, 1993
 ;;V 4.5
G0 ;initializes array
 S A1=0 F I=1:1 S A1=$O(^DG(40.8,A1)) Q:(A1="")!(A1'?.N)  S A(I)=^DG(40.8,A1,0),A2=I,DGDV=$E($P(A(I),U,2)_"     ",1,5) S ^UTILITY("DGOD",$J,"AO",I)=A(I) F K1=1:1:DGTN D G1
 Q
 ;
G1 ;zero each cell
 S ^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)=0 F DGV="N","V" F DGMT="AN","AS","B","C","N","U","X" F DGEL="*",0:1:8 S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,DGMT,DGEL)=0
 ;zero row subtotal
 F DGV="N","V" F DGEL="*",0:1:8 S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGEL)=0
 ;zero column subtotal
 F DGV="N","V" F DGMT="AN","AS","B","C","N","U","X" S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGMT)=0
 ;zero vet/nonvet subtotal
 F DGV="N","V" S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,"TOT",DGV)=0
 ;zero column total for division
 F DGMT="AN","AS","B","C","N","U","X" S (^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,DGMT),^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGMT))=0
 ;zero division total
 S ^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)=0
 ;zero grand total
 S ^UTILITY("DGOD",$J,"TOT",DGJB,K1)=0
 Q
 ;
T0 ;totals the array
 F I=1:1:A2 S DGDV=$E($P(A(I),U,2)_"     ",1,5) F K1=1:1:DGTN D T1
 Q
 ;
T1 ;row subtotal for vet/non-vet
 F DGV="N","V" S DGK=$S(DGV="N":8,1:6) F DGMT="AN","AS","B","C","N","U","X" F DGEL=0:1:DGK,"*" S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGEL)=^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGEL)+^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,DGMT,DGEL)
 ;column subtotal for vet/non-vet
 F DGV="N","V" S DGK=$S(DGV="N":8,1:6) F DGEL=0:1:DGK,"*" F DGMT="AN","AS","B","C","N","U","X" S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGMT)=^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGMT)+^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,DGMT,DGEL)
 ;subtotal vet/non-vet
 F DGV="N","V" S DGK=$S(DGV="N":8,1:6) F DGEL=0:1:DGK,"*" S ^UTILITY("DGOD",$J,DGJB,K1,DGDV,"TOT",DGV)=^UTILITY("DGOD",$J,DGJB,K1,DGDV,"TOT",DGV)+^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGEL)
 ;column total for division
 F DGV="N","V" F DGMT="AN","AS","B","C","N","U","X" S ^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,DGMT)=^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,DGMT)+^UTILITY("DGOD",$J,DGJB,K1,DGDV,DGV,"TOT",DGMT)
 ;division total
 F DGV="N","V" S ^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)=^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)+^UTILITY("DGOD",$J,DGJB,K1,DGDV,"TOT",DGV)
 ;grand total for all columns
 F DGMT="AN","AS","B","C","N","U","X" S ^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGMT)=^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGMT)+^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV,DGMT)
 ;grand total
 S ^UTILITY("DGOD",$J,"TOT",DGJB,K1)=^UTILITY("DGOD",$J,"TOT",DGJB,K1)+^UTILITY("DGOD",$J,DGJB,K1,"TOT",DGDV)
 K DGK Q
 ;
ET ;elapsed time for run
 Q:$D(H1)=0  S H2=$H D ET1
 S DGTOUT=$S(DGTOUT<60:$J(DGTOUT,1,2)_" secs",DGTOUT<3600:$J(DGTOUT/60,1,2)_" min",1:$J(DGTOUT/3600,1,2)_" hrs") Q
 ;
ET1 ;H1-start time,H2-end time,DGTOUT-difference in seconds
 S H1(1)=$P(H1,",",1),H1(2)=$P(H1,",",2),H2(1)=$P(H2,",",1),H2(2)=$P(H2,",",2)
 I H1(1)=H2(1) S DGTOUT=H2(2)-H1(2) Q
 S DGTOUT=86400*(H2(1)-H1(1))+(H2(2)-H1(2)) Q
