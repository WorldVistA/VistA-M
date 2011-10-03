PSOCPIB4 ;BIR/EJW-Clean up to bill unbilled NON-SERVICE CONNECTED copays ;12/12/02
 ;;7.0;OUTPATIENT PHARMACY;**123**;DEC 1997
GETDATE ; GET DATE/TIME OF WHEN BACKGROUND JOB SHOULD BE RUN
 S ZTDTH=""
 I '$D(PSOQUES) S PSOQUES="Queue job to run at Date@Time: "
 S NOW=0
 D NOW^%DTC S (Y,TODAY)=% D DD^%DT
 D BMES^XPDUTL("At the following prompt, enter a starting date@time")
 D MES^XPDUTL("or enter NOW to queue the job immediately.")
 D BMES^XPDUTL("If this prompting is during patch installation, you will not see what you type.")
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")=PSOQUES
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W "Task will be queued to run NOW" S ZTDTH=$H,NOW=1
 I 'NOW,Y>0 D
 .S SAVEY=Y
 .D DD^%DT
 .S X=Y
 .S Y=SAVEY
ASK D BMES^XPDUTL("Task will be queued to run "_$S(NOW:"NOW",1:X)_". Is that correct?  :")
 R XX:300 S:'$T XX="Y" I XX'="Y",XX'="y",XX'="N",XX'="n" W " Enter Y or N" G ASK
 I XX'="Y",XX'="y" G GETDATE
 I Y>0,ZTDTH="" S ZTDTH=Y
 I ZTDTH="" S ZTDTH=$H
 Q
 ;
