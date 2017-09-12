RMPRPST ;HISC/RVD - POST INIT FOR HCPCS CONVERSION;1/02/98
 ;;3.0;PROSTHETICS;**28**,JAN 02,1998
 W !,$C(7),"Invalid Entry......"
 Q
START ;x-ref field 4.1 in file 660
 W !!!!!!!!!!! D XREF^RMPRSE2
660 ;HCPCS conversion for file 660
 ;quit conversion if 661.1 was not transported correctly
 I '$D(^RMPR(661.1,"E",104613,2575)) W !,$C(7),"**** Unable to continue POST INIT,  file 661.1 was not transported correctly !!!!" Q
 S RMFILE=660
 W !!,"***** CONVERTING HCPCS entry for 660...."
 S I=0 F  S I=$O(^RMPR(660,I)) Q:I'>0  S RMHIEN=$P($G(^RMPR(660,I,0)),U,22) I RMHIEN,(RMHIEN>3000) D GETHC S $P(^RMPR(660,I,1),U,4)=RM6611
 W !,$C(7),"***** FILE 660, HCPCS CONVERSION IS DONE!!!!"
 ;
664 ;hcpcs conversion for file 664
 S RMFILE=664
 W !!,"***** CONVERTING HCPCS entry for 664...."
 S I=0 F  S I=$O(^RMPR(664,I)) Q:I'>0  F J=0:0 S J=$O(^RMPR(664,I,1,J)) Q:J'>0  S RMHIEN=$P($G(^RMPR(664,I,1,J,0)),U,16) I RMHIEN,(RMHIEN>3000) D GETHC S $P(^RMPR(664,I,1,J,0),U,16)=RM6611
 W !,$C(7),"***** FILE 664, HCPCS CONVERSION IS DONE!!!!"
 ;
6641 ;hcpcs conversion for file 664.1
 S RMFILE=664.1
 W !!,"***** CONVERTING HCPCS entry for 664.1...."
 S I=0 F  S I=$O(^RMPR(664.1,I)) Q:I'>0  F J=0:0 S J=$O(^RMPR(664.1,I,2,J)) Q:J'>0  S RMHIEN=$P($G(^RMPR(664.1,I,2,J,2)),U,1) I RMHIEN,(RMHIEN>3000) D GETHC S $P(^RMPR(664.1,I,2,J,2),U,1)=RM6611
 W !,$C(7),"***** FILE 664.1, HCPCS CONVERSION IS DONE!!!!"
 W !!,$C(7),"Note: Conversion of HCPCS has completed successfully."
 W !,?6,"You can let Prosthetic users back to the system !!!!!"
KILL K I,J,RMFILE,RMHIEN,RM6611,RMHCPC
 Q
 ;
GETHC ;get hcpcs IEN from 661.1
 S RM6611=$O(^RMPR(661.1,"E",RMHIEN,0)) S:'RM6611 RM6611=2430
 Q
