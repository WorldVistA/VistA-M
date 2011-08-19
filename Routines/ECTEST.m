ECTEST ;B'ham ISC/PTD-Display Planned Equipment Status ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731.5)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Planned Equipment' File - #731.5 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731.5,0)) W *7,!!,"'VAMC Planned Equipment' File - #731.5 has not been populated on your system.",!! S XQUIT="" Q
 ;
CHS W !!,"Choose the equipment 'status':",!!,"1.  Requested, but not yet approved or purchased",!,"2.  Approved to be purchased",!,"3.  Approved and purchased",!!,"Choose a number (1 - 3): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>3) W !!,*7,"You MUST answer with a number between 1 and 3." G CHS
EN1 ;ENTRY POINT, 'CHS' SET BY ANOTHER ROUTINE
DIP S DIC="^ECT(731.5,",L=0,BY="@23,1" S DHD=$S(CHS=3:"PURCHASED",CHS=2:"APPROVED",1:"REQUESTED, NOT APPROVED"),DHD=DHD_" EQUIPMENT"
 I CHS=1 S FLDS="1;L20,.01;C24,20,6;C70&",(FR,TO)="N"
 I CHS=2 S FLDS="1;L20,.01;C24,21,6;C70&",(FR,TO)="A"
 I CHS=3 S FLDS="1;L20,.01;C24,22,6;C70&",(FR,TO)="P"
 D EN1^DIP
EXIT K %X,B,BY,CHS,DHD,DIC,DIS,FLDS,FR,L,TO
 Q
 ;
