RADTICK ;HIRMFO/GJC-Rad/Nuc Med Dosage Ticket output ;10/29/96  14:21
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1(RADA1,RADA) ; Entry point to print dosage ticket
 ; Input Variables:
 ; RADA1: ien for top level of Nuc Med Exam Data file (70.2)
 ; RADA : ien for sub-file level of Nuc Med Exam Data file (70.21)
 N RAEXAM,RAFDA,RAHD1,RALINE,RAPAT,RAPIEN,RAPROC,RAXAM,RAXIT
 D GETS^DIQ(70.2,RADA1_",","**","","RAEXAM")
 S RAPIEN=+$P($G(^RADPTN(RADA1,0)),"^"),RAFDA=RADA_","_RADA1_","
 S RAXAM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RAPROC=$S($P($G(^RAMIS(71,+$P(RAXAM,"^",2),0)),"^")]"":$P(^(0),"^"),1:"Unknown")
 D GETS^DIQ(2,+$P($G(^RADPTN(RADA1,0)),"^")_",",".01;.09","","RAPAT") D HDR
 W !!?3,"PATIENT: ",$G(RAPAT(2,+$P(RAEXAM,"^")_",",.01))
 W !!?3,"PATIENT ID: ",$G(RAPAT(2,+$P(RAEXAM,"^")_",",.09))
 W !!?3,"STUDY: ",RAPROC
 Q
HDR ; Header for the dosage ticket
 W:$Y @IOF
 S RAHD1="Radiopharmaceutical Dose Computation and Measurement Record"
 S $P(RALINE,"-",($L(RAHD1)+1))=""
 W $$CJ^XLFSTR(RAHD1,IOM) W $$CJ^XLFSTR(RALINE,IOM)
 Q
