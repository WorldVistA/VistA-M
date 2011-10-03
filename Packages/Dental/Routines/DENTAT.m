DENTAT ;ISC2/SAW-CREATE DENTAL SERVICE TAPE ; 7/21/88  5:42 PM ;
 ;;VERSION 1.2
 W !,*7,"This option will create the Dental Service Magnetic Tape",!,"Which must be sent to the Austin TX DPC"
 R !,"Are you sure you want to continue? N// ",X:DTIME S:X=""!(X["^") X="N" G:X["N" EXIT
 I '$D(^UTILITY("DENTV")) W !!,"There is no data in the Dental Service Tape global???  Can't write a tape without data.",*7 G EXIT
OPEN R !,"Press the return key when Magtape device is ready: ",X:DTIME G EXIT:'$T,EXIT:X="^",OPEN:X'=""
 S IOP="AMIS TAPE" D ^%ZIS U IO I POP U IO(0) W !,*7,"Unable to open Magtape device" G OPEN
 S DENTI=^DD("OS"),DENTOS=$S($D(^DD("OS",DENTI,0)):$P(^(0),"^",1),1:"") I DENTOS']"" G OSERR
 S DENTTP=$S(DENTOS["DSM":2,DENTOS["M/11+":1,DENTOS["M/11":2,1:0) I 'DENTTP G OSERR
 U IO S DENTTP1=$S(DENTTP=1:"*-5,*-8",DENTTP=2:"*5,*8",1:"") W @DENTTP1
 S N="",J1=^UTILITY("DENTV") F I=1:1:J1 S N=$O(^UTILITY("DENTV",N)) Q:N=""  W $E(^(N,0),1,80)
 D FILL S DENTTP1=$S(DENTTP=1:"*-4,*-9,*-5",DENTTP=2:"*4,*9,*5",1:"") W @DENTTP1
 X ^%ZIS("C") U IO(0) W !,J1," Records were written to tape."
EXIT K I,IOP,J1,N,N1,X,DENTTP,DENTTP1,DENTOS,DENTI Q
FILL Q:'((I-1)#10)  S DENTFILL=((I-1)#10)+1,DENTJ="" F J=1:1:80 S DENTJ=DENTJ_"X"
 F J=DENTFILL:1:10 W $E(DENTJ,1,80)
 K DENTJ,J,DENTFILL Q
OSERR X ^%ZIS("C") U IO(0) W !,*7 F I=0:1:79 W "*"
 W !,"This routine is not designed to run on your present operating system.",!,"  Contact your regional ISC for information on how to continue.",!!!,"  PLEASE NOTE: NO DATA HAS BEEN OUTPUT TO THIS TAPE!!!"
 W ! F I=0:1:79 W "*"
 Q
