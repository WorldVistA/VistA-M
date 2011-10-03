DVBCPWC1 ;ALB ISC/THM-POW EXAM, CONTINUED ; 5/14/91  1:05 PM
 ;;2.7;AMIE;;Apr 10, 1995
 G EN
 ;
L I $Y>55 D HD2^DVBCPWCK
 Q
 ;
EN F I="bleeding","lumps or masses","vertigo","syncope","pruritis","rash","diabetes mellitus","thyroid disorders","cancer" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"b. Head, eye, ear, nose and throat",!! S CNT=0 F I="skull","scalp","vison/changes","diplopia","eye pain","conjunctivae","cornea","sclera","lens","pupils","fundi" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"Ears:",!! S CNT=0 F I="hearing loss","external ear","canals/drums","tinnitus" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"Nose:",!! S CNT=0 F I="external","mucosa","septum","turbinates" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"Mouth-throat:",!! S CNT=0 F I="lips","breath","teeth - dentures","bleeding gums","tongue","mucosa","tonsils","pharynx","speech","salivary glands","hoarseness" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"c. Neck:",!! S CNT=0 F I="range of motion","appearance","trachea","thyroid","masses" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"d. Breasts:",!! S CNT=0 F I="lumps","pain or tenderness","nipple discharge" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"e. Nodes:",!! S CNT=0 F I="cervical","axillary","inguinal" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"Musculoskeletal - spine,upper and lower extremeties:",!!
 S CNT=0 F I="mobility, tenderness, pain of spine","joint pain","stiffness","joint swelling","muscle weakness","edema","ambulation","coordination" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"g. Respiratory:",!! S CNT=0 F I="cough","sputum","rheumatic fever","pleurisy","pneumonia","tuberculosis","shortness of breath","wheezing","asthma","pulmonary embolus" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="configuration of thorax","respiratiory movements","percussion","inspiratory breath sounds","expiratiory breath sounds" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"h. Cardiovasular:",!!
 S CNT=0 F I="heart inpulse","palpation, rhythm, auscultation","hypertension","rheumatic fever","chest pain/discomfort","shortness of breath","paroxysmal nocturnal dyspnea" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="murmurs","edema","pulses","neck veins","peripheral veins","claudication","thrombophlebitis" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"i. Gastrointestinal:",!!
 S CNT=0 F I="dysphagia","heartburn","nausea and vomiting","hematemesis","melena","abdominal wall/distention/tenderness","food intolerance","bowel sounds","ventral hernia","hepatitis" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="gastric/marginal/duodenal ulcer","pancreatitis" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"j. Genitourinary:",!! S CNT=0 F I="nocturia/dysuria","incontinence","dribbling","polyuria","urinary infection","stones","veneral disease","discharge","impotence","penis" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 F I="scrotum","testes","epididymis","inguinal canal" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"Female:",!! F I="external genitalia","uretha","vagina","uterus","adnexa","abnormal menses","vaginal discharge","menorrhagia","dyspareunia","menopause","contraception" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"k. Rectal:",!! S CNT=0 F I="anus and sphincter","rectum","prostate","test for occult blood" S CNT=CNT+1 W ?($S(CNT<10:7,1:6)),CNT,". ",I,!! D L
 W ?4,"l. Neurological:",!!
 G ^DVBCPWC4
