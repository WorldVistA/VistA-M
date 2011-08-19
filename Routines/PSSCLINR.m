PSSCLINR ;;BIR/RTR-API FOR CLINICAL REMINDERS; 21 Jan 08
 ;;1.0;PHARMACY DATA MANAGEMENT;**133**;9/30/97;Build 1
 ;
 ;Return AND or VAC index of File 50
 ;PSSCRIX = AND or VAC
 ;PSSCRIV = Data value for Index
IX(PSSCRIX,PSSCRIV) ;
 I $G(PSSCRIX)'="AND",$G(PSSCRIX)'="VAC" Q
 I '$G(PSSCRIV) Q
 K ^TMP($J,PSSCRIX,PSSCRIV)
 M ^TMP($J,PSSCRIX,PSSCRIV)=^PSDRUG(PSSCRIX,PSSCRIV)
 Q
 ;
 ;Return Drug Name from File 50
 ;PSSCLID = File 50 IEN
DRUG(PSSCLID) ;
 Q $P($G(^PSDRUG(+$G(PSSCLID),0)),"^")
 ;
 ;Return Pharmacy Orderable Item Pointer from File 50
 ;PSSCLII = File 50 IEN
ITEM(PSSCLII) ;
 Q $P($G(^PSDRUG(+$G(PSSCLII),2)),"^")
 ;
ING(PSSING) ;Return Drug ingredient Name
 Q $P($G(^PS(50.416,PSSING,0)),"^")
IEN(PSSING) ;Return Drug Ingredient IEN
 I '$D(^PS(50.416,"B",PSSING)) Q -1
 Q $O(^PS(50.416,"B",PSSING,0))
 ;
NEPS() ;Return number of entries in PS(55).
 N ADD,DA,DA1,DFN,DRUG,IND,NE,SDATE,SOL,STARTD,TEMP
 ;DBIA #4181
 S (DFN,IND,NE)=0
 F  S DFN=+$O(^PS(55,DFN)) Q:DFN=0  D
 .;Process Unit Dose.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,5,DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,5,DA,2))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" Q
 ..;If the order is purged then SDATE is 1.
 .. S SDATE=$P(TEMP,U,4)
 .. I SDATE=1 Q
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,5,DA,1,DA1)) Q:DA1=0  D
 ... S DRUG=$P(^PS(55,DFN,5,DA,1,DA1,0),U,1)
 ... I DRUG="" Q
 ... S NE=NE+1
 .;Process the IV mutiple.
 . S DA=0
 . F  S DA=+$O(^PS(55,DFN,"IV",DA)) Q:DA=0  D
 .. S TEMP=$G(^PS(55,DFN,"IV",DA,0))
 .. S STARTD=$P(TEMP,U,2)
 .. I STARTD="" Q
 .. S SDATE=$P(TEMP,U,3)
 .. I SDATE=1 Q
 ..;Process Additives
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"AD",DA1)) Q:DA1=0  D
 ... S ADD=$P(^PS(55,DFN,"IV",DA,"AD",DA1,0),U,1)
 ... I ADD="" Q
 ... S DRUG=$P($G(^PS(52.6,ADD,0)),U,2)
 ... I DRUG="" Q
 ... S NE=NE+1
 ..;Process Solutions
 .. S DA1=0
 .. F  S DA1=+$O(^PS(55,DFN,"IV",DA,"SOL",DA1)) Q:DA1=0  D
 ... S SOL=$P(^PS(55,DFN,"IV",DA,"SOL",DA1,0),U,1)
 ... I SOL="" Q
 ... S DRUG=$P($G(^PS(52.7,SOL,0)),U,2)
 ... I DRUG="" Q
 ... S NE=NE+1
 Q NE
