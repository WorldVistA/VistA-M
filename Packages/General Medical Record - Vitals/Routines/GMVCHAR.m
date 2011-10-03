GMVCHAR ;HIOFO/YH,FT-EXTRACT CHARACTERISTIC DATA ;11/8/01  14:33
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
CHAR(GDA,GARRY,X) ;
 ; Input data:
 ; GDA - Pointer to patient vitals/measurements file #120.5
 ; X - Pointer to the vital type file #120.51
 ; Output data array:
 ; GARRY(GDA,print order,qualifier data)
 N GMRVORDR,GMRVDA,GMRVCAT,GMRVCHAR
 S GMRVDA(1)=0 F  S GMRVDA(1)=$O(^GMR(120.5,GDA,5,"B",GMRVDA(1))) Q:GMRVDA(1)'>0  D
 .  Q:'$D(^GMRD(120.52,GMRVDA(1),0))  S GMRVCHAR=$P($G(^GMRD(120.52,GMRVDA(1),0)),"^")
 .  S GMRVDA(2)=$O(^GMRD(120.52,GMRVDA(1),1,"B",X,0)) I GMRVDA(2)'>0 S GARRY(GDA,1,GMRVCHAR)="" Q
 .  S GMRVCAT=+$P($G(^GMRD(120.52,GMRVDA(1),1,GMRVDA(2),0)),"^",2)
 . S GMRVCAT(1)=$O(^GMRD(120.53,"C",X,GMRVCAT,0)) Q:GMRVCAT(1)'>0
 . Q:'$D(^GMRD(120.53,GMRVCAT,1,GMRVCAT(1)))
 . S GMRVORDR=+$P($G(^GMRD(120.53,GMRVCAT,1,GMRVCAT(1),0)),"^",5) I GMRVORDR=0 S GMRVORDR=1
 .  S GARRY(GDA,GMRVORDR,GMRVCHAR)=""
 .  Q
 Q
WRITECH(GDA,GARRY,GN) ;
 ; Input data:
 ; GDA - Pointer to the patient vitals/measurements data file #120.5
 ; GARRY - qualifier data array for a measurement
 ;         GARRY(GDA,Print order,qualifier data)
 ; GN - Number of print order to print
 N GMRVDA,GDATA
 S GDATA="",GMRVDA(1)=0 F  S GMRVDA(1)=$O(GARRY(GDA,GMRVDA(1))) Q:GMRVDA(1)'>0!(GMRVDA(1)>GN)  S GMRVDA(2)="" F  S GMRVDA(2)=$O(GARRY(GDA,GMRVDA(1),GMRVDA(2))) Q:GMRVDA(2)=""  D
 . S GDATA=GDATA_$S(GDATA'="":", ",1:"")_GMRVDA(2)
 Q GDATA
