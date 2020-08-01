ISIIMP28 ;ISI GROUP/MLS -- Treating Facility List Import API
 ;;3.0;ISI_DATA_LOADER;;Jun 26, 2019;Build 80
 ;
 ; VistA Data Loader 2.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ;Licensed under the Apache License, Version 2.0 (the "License");
 ;you may not use this file except in compliance with the License.
 ;You may obtain a copy of the License at
 ;
 ;    http://www.apache.org/licenses/LICENSE-2.0
 ;
 ;Unless required by applicable law or agreed to in writing, software
 ;distributed under the License is distributed on an "AS IS" BASIS,
 ;WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ;See the License for the specific language governing permissions and
 ;limitations under the License.
 ;
 Q
TFL(ISIRESUL,ISIMISC)
 N ERR,VAL
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 ;Validate setup & parameters
 S ISIRC=$$VALIDATE Q:+ISIRC<0 ISIRC
 ;Create patient record
 S ISIRC=$$MAKETFL Q:+ISIRC<0 ISIRC
 Q ISIRC
 ;
VALIDATE() ;
 ; Validate import array contents
 S ISIRC=$$VALTFL^ISIIMPUH(.ISIMISC)
 Q ISIRC
 ;
MAKETFL() ;
 ; Create patient(s)
 S ISIRC=$$CTFL(.ISIMISC)
 Q ISIRC
 ;
CTFL(ISIMISC) ;Create Treating Facility Entry
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("DFN")=123455
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0)=1 [if successful]
 ;          ISIRESUL(1)=TFLIEN [if successful]
 ;
 N DFN,INST,ADTHL7,ISSDT
 ;
 S ISIRC=1
 D PREP
 I +ISIRC<0 Q ISIRC
 D CREATE
 I +ISIRC<0 Q ISIRC
 S ISIRESUL(0)=1
 S ISIRESUL(1)=+ISIRC
 Q ISIRC
 ;
PREP ;
 ;
 N EXIT
 S DFN=ISIMISC("DFN") ;"" ;POINTER TO PATIENT FILE (#2)
 S INST=ISIMISC("INST") ; Institution
 S ISSDT=ISIMISC("DATE") ;DATE LAST TREATED
 S ADTHL7=3 ; ADT/HL7 EVENT REASON (default is CHECKED OUT (CLINIC))
 I $$DUPCHECK() S ISIRC="-1^Duplicate Treating Facility List entry found."
 Q
 ;
DUPCHECK() ;
 I '$D(^DGCN(391.91,"C",$G(INST))) Q 0
 N X,EXIT S (X,EXIT)=0 F  S X=$O(^DGCN(391.91,"C",$G(INST),X)) Q:'X!EXIT  D
 . I $P($G(^DGCN(391.91,X,0)),U)=$G(DFN) S EXIT=X Q
 . Q
 ;
 Q EXIT
 ;
CREATE ;
 N FDA,IENS K FDA
 S IENS="+1,"
 S ISIRC=0
 D MKARRY
 D UPDATE^DIE("S","FDA",,"MSG")
 I $G(DIERR)'="" S ISIRC="-1^"_$G(MSG("DIERR",1,"TEXT",1))
 ; Now add the local site
 S ICN=$$GETICN^MPIF001(DFN) Q:+ICN<1
 S ^TMP($J,1)=+$$SITE^VASITE_"^"_$$NOW^XLFDT
 D FILETF^VAFCTFU(ICN,"^TMP($J)")
 Q ISIRC
 ;
MKARRY ;
 ;
 S FDA(391.91,IENS,.01)=DFN
 I $G(INST)'="" S FDA(391.91,IENS,.02)=INST
 I $G(ISSDT)'="" S FDA(391.91,IENS,.03)=ISSDT
 I $G(ADTHL7)'="" S FDA(391.91,IENS,.07)=ADTHL7
 Q
