MCARAML ;WASH ISC/JKL-MUSE AUTO INSTRUMENT RETRANSMISSION LIST ;2/27/95  10:52
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
START ; Driver for retransmission list-run during patch install
 ; Sends an alphabetized list of corrupted records and records
 ; with transmission errors from error summary file
 N MCCNT,MCDEF
 S MCCNT=0
 S ^TMP($J,0,"MC",0)=0,^TMP($J,1,"MC",0)=0
 W !,"This process will compile a list of EKG records that"
 W !,"are corrupted in DHCP."
 W !!,"The records have originated from the Marquette MUSE,"
 W !,"and are retransmissable to DHCP from there."
 R !!,"Do you wish to continue ? N //",MCDEF:30 I '$T Q
 I $E(MCDEF)'="Y" Q
 W !!,"Each  "".""  represents 100 records.",!!,"Compiling---"
 ; checks for whole records
 D ^MCARAMLA
 D ^MCARAMLB
 D ^MCARAMLC
 D ^MCARAMLD
 D ^MCARAMLE
 D ^MCARAMLF
 D ^MCARAMLG
 W !!,MCCNT," records compiled."
 D ^MCARAMLH
 W !!,"...done."
 Q
