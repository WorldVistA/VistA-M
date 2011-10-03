ECTEPR ;B'ham ISC/PTD-Display Planned Equipment Priority ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731.5)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Planned Equipment' File - #731.5 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731.5,0)) W *7,!!,"'VAMC Planned Equipment' File - #731.5 has not been populated on your system.",!! S XQUIT="" Q
 ;
CHS W !!,"This report may be printed for:",!!,"1.  Additional Equipment",!,"2.  Replacement Equipment",!,"3.  Regional High Technology Equipment",!,"4.  IRM/ADP Equipment",!!,"Choose a number (1 - 4): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>4) W !!,*7,"You MUST answer with a number between 1 and 4." G CHS
DIP S DIC="^ECT(731.5,",L=0,BY="5,1",(FR,TO)="" S DHD=$S(CHS=4:"VAMC IRM/ADP",CHS=3:"VAMC REGIONAL HIGH TECH",CHS=2:"VAMC REPLACEMENT",1:"VAMC ADDITIONAL"),DHD=DHD_" EQT. REQUESTS"
 S DIS(0)="I $P(^ECT(731.5,D0,1),""^"",4)'=""P"""
 I CHS=1 S DIS(1)="I $P(^ECT(731.5,D0,0),""^"",5)=""A""&($P(^(0),""^"",3)'=1)&($P(^(0),""^"",4)'=1)"
 I CHS=2 S DIS(1)="I $P(^ECT(731.5,D0,0),""^"",5)=""R""&($P(^(0),""^"",3)'=1)&($P(^(0),""^"",4)'=1)"
 I CHS=3 S DIS(1)="I $P(^ECT(731.5,D0,0),""^"",3)=1"
 I CHS=4 S DIS(1)="I $P(^ECT(731.5,D0,0),""^"",4)=1"
 I CHS=1!(CHS=2) S FLDS="5,1;C7;L25,.01;C35,INTERNAL(#23);""STATUS"",6;C70&"
 I CHS=3!(CHS=4) S FLDS="5,1;C7;L20,.01;C30,INTERNAL(#4);L3;""ADL REP"",INTERNAL(#23);L6;""STATUS"",6;C70&"
 D EN1^DIP
EXIT K %X,BY,CHS,DHD,DIC,DIS,FLDS,FR,L,TO
 Q
 ;
