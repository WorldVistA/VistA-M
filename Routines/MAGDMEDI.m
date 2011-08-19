MAGDMEDI ;WOIFO/LB - Routine for Medicine DICOM ID ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
DICOMID(RETURN,MAGMFILE,MAGMFIEN,MAGPROC,MAGDFN) ;
 ;MAGMFILE= Medicine file number  ( i.e. 699 , 699.5  etc)
 ;MAGMFIEN= Medicine file entry, IEN  (699,xxx)
 ;MAGPROC=  Medicine procedure IEN  ( 697.2,yyy points to 699, 699.5 etc)
 ;MAGDFN=   Patient's DFN 
 ; RETURN piece 1= 1 or 0
 ;        piece 2= DICOM ID  
 ;           DICOM ID= medicine file id code-Medicine file IEN
 N OK,MAGID,MCFILE
 S RETURN="0^Invalid information sent"
 Q:'MAGMFILE!('MAGMFIEN)!('MAGDFN)
 ; Will check to see if valid information is sent
 I '$D(^MAG(2005.03,MAGMFILE)) D  Q
 . S RETURN="0^Invalid Imaging Parent file."
 S MCFILE=MAGMFILE
 S OK=$$VALID^MCUIMAG0(MAGMFILE,MAGMFIEN,MAGDFN,MAGPROC)
 I 'OK S RETURN=OK Q
 ;
 S MAGID=$$TYPE(MAGMFILE)
 S RETURN="1^DICOM ID: "_MAGID_"-"_MAGMFIEN
 Q
TYPE(FILE) ;Set the id code for the Medicine file
 ; If we add addtl. Medicine files, the following will need to be chgd.
 N MAGCODE
 S MAGCODE="unknown"
 I 'FILE Q MAGCODE
 S MAGCODE=$S(FILE=691:"EC",FILE=691.1:"CC",FILE=691.5:"EL",FILE=694:"HE",FILE=699:"EN",1:"GM")
 Q MAGCODE
FILE(CODE) ;Set the file number according to the Medicine id file code
 ; If we add addtl. Medicine files, the following will need to be chgd.
 ; Default is the Generalized Procedure/Consult Medicine file.
 N MAGFILE
 I '$D(CODE) Q 0
 S MAGFILE=$S(CODE="EC":691,CODE="CC":691.1,CODE="EL":691.5,CODE="HE":694,CODE="EN":699,1:699.5)
 Q MAGFILE
