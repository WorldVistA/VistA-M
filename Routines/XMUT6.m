XMUT6 ;(WASH ISC)/CAP-Check delivery queue ;04/17/2002  12:07
 ;;8.0;MailMan;;Jun 28, 2002
 W !!,"Checking Delivery Queue: " S %H=$H D YX^%DTC W Y
 D GO^XMUT5B I M("T")+R("T")<1 W !!,"NOTHING IS IN THE DELIVERY QUEUE !!" Q
 ;
GO ;Go through the queues and see if the data in them is correct
 K M,R,T
 S (M,R,T,M("D"),R("D"),T("D"))=0 F I=1:1:10 S (M(I),M("D",I),R(I),R("D",I))=0
 F I="M","R" F J=1:1:10 D COUNT
 W !!,"Total items Waiting to be delivered: ",T
 W !,"Messages: "_M,"   Responses: "_R
 W !,"Message Deliveries: "_M("D")_"   Response Deliveries: "_R("D")
 I M>0 W !!,"Message Group      # Messages    # Deliveries"
 I  F I=1:1:10 Q:'$D(M(I))  W !,?5,I,?25,M(I),?40,M("D",I),?53
 I R>0 W !!,"Response Group     # Responses   # Deliveries"
 I  F I=1:1:10 Q:'$D(R(I))  W !,?5,I,?25,R(I),?40,R("D",I),?53
Q D ^XMUT5
 Q
 ;
 ;Count the actual stuff in the queues
COUNT S (A,B,C)=0 ; I=group, J=queue, A=timestamp, B=id
A S A=$O(^XMBPOST(I,J,A)) Q:A'>0  S B=""
B S B=$O(^XMBPOST(I,J,A,B)) G A:B=""
 ;
 ;Messages
 I I="R" S C="" G C
 I B[U D FWD
 E  S %=+$G(^(B))
 S T=T+1,M=M+1,M(J)=M(J)+1,M("D")=M("D")+%,M("D",J)=M("D",J)+%,T("D")=T("D")+%
 G B
 ;
 ;Responses
C S C=$O(^XMBPOST(I,J,A,B,C)) G B:C="" S %=+$G(^(C)) G C:'%
 S T=T+1,R=R+1,R(J)=R(J)+1,R("D")=R("D")+%,R("D",J)=R("D",J)+%,T("D")=T("D")+%
 G C
 ;
 ;Sum up forwards
FWD S (%,K)=0 F  S K=$O(^XMBPOST("FWD",B_U_A,K)) Q:'K  S %=%+$L($G(^(K)),U)
 Q
MOVE ;Move queue 1 to queue 3
 S A="^XMBPOST(""R"",1)",B=0
MA S A=$Q(@A) Q:$P(A,$C(34),2)'="R"
 S B=B+1 G MA:B<2 S C=@A,D=A,$P(D,",",2)=3,@D=C K @A G MA
 ;
KILL ;Kill off X-ref of Responses
 S A="R"
KA S A=$O(^XMBPOST("R",A)) Q:A=""  W A,"  " K ^(A) G KA
