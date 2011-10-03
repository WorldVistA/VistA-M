GMVUTL2 ;HOIFO/YH,FT-BP HIGH/LOW LIMITS AND DEFAULT QUALIFIER; 6/7/98 ;10/1/02  14:14
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #1377 - ^DIC(42 references     (supported)
 ;  #3227 - ^NURAPI calls          (private)
 ;  #3771 - ^XUDHGUI calls         (supported)
 ; #10035 - ^DPT( references       (supported)
 ; #10039 - ^DIC(42 references     (supported)
 ; #10061 - ^VADPT calls           (supported)
 ;
WARDPT ;
 K ^TMP($J) S GMRWARD=+$O(^DIC(42,"B",GMRWARD(1),0)),GMRVHLOC=$$HOSPLOC^GMVUTL1(GMRWARD)
 S DFN=0 F  S DFN=$O(^DPT("CN",GMRWARD(1),DFN)) Q:DFN'>0  D
 . D 1^VADPT S GMRNAM=$G(VADM(1)),GMRRMBD=$P($G(VAIN(5)),"^")
 . S:GMRNAM="" GMRNAM=" " S:GMRRMBD="" GMRRMBD=" "
 . S ^TMP($J,GMRRMBD,GMRNAM,DFN)=""
 Q
UNITWRD ; Called by location report (GMVGRPH routine)
 N GMVOUT
 S GMVOUT=$$FINDNLOC^NURAPI("NUR "_GMRWARD(1))
 S GMRWARD=+$P(GMVOUT,U,1),GMRVHLOC=+$P(GMVOUT,U,2)
 I '$$PTCHK^NURAPI() S GMRWARD=0 Q
 Q
UNITPT ; Called by location report (GMVGRPH routine)
 N GMVIEN,GMVOUT S GMVIEN=0
 D APTLIST^NURAPI(GMRWARD,.GMVOUT)
 F  S GMVIEN=$O(GMVOUT(GMVIEN)) Q:'GMVIEN  D
 . S DFN=$P(GMVOUT(GMVIEN),U,1)
 . D 1^VADPT S GMRNAM=$G(VADM(1)),GMRRMBD=$P($G(VAIN(5)),"^")
 . S:GMRNAM="" GMRNAM=" " S:GMRRMBD="" GMRRMBD=" "
 . S ^TMP($J,GMRRMBD,GMRNAM,DFN)=""
 Q
CHKDEV(GMVLIST,GMVIEN,GMVDIR,GMVRMAR) ; Returns a list of printers
 ; RESULT  - TMP array address
 ; GMVIEN  - Value to begin the search. Can be null.
 ; GMVDIR  - Direction of the search (1 = forward, -1 = backwards)
 ;           If DIR is null, then set to 1.
 ; GMVRMAR - Right margin (e.g, 80, 132 or "80-132")
 S:GMVDIR="" GMVDIR=1
 S:GMVRMAR="" GMVRMAR=132
 D DEVICE^XUDHGUI(.GMVLIST,GMVIEN,GMVDIR,GMVRMAR)
 ; If no devices found, the array has no entries.
 Q
