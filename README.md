# Course Projects in AI, ML, DL, and CV
A collection of academic projects exploring Artificial Intelligence, Machine Learning, Deep Learning, and Computer Vision concepts through practical implementations.
I would be glad if these projects are useful for learning, reference, or further development. If you find them helpful, please consider giving the repository a ⭐ star. 

## Projects

### 1. CAN-Based Monitoring and Control System

An embedded IoT project implementing communication between Raspberry Pi and ESP32 boards using the CAN bus protocol. The Slave node reads temperature data from an LM75 sensor and controls an LED and relay, while the Master node collects status information and provides MQTT-based monitoring and control capabilities.

The implementation demonstrates CAN communication, I2C sensor interfacing, GPIO control, and MQTT integration for an embedded monitoring system.

### 2. Ensemble Classification and MLP Optimization

Developement of classification experiments comparing individual machine learning models, ensemble learning approaches, and optimized neural network classifiers.

This project evaluates multiple classification algorithms, including KNN, SVM, AdaBoost, XGBoost, Naive Bayes, and Random Forest, and analyzes their performance individually and in ensemble configurations. Additionally, an MLP-based classifier is developed and optimized through architecture selection and hyperparameter tuning to improve classification performance.

### 3. Camera Calibration and Pose Estimation

Implementation of a computer vision project focused on camera calibration and 3D geometry analysis.

The project applies Zhang's camera calibration algorithm to estimate a camera's intrinsic and extrinsic parameters using chessboard calibration patterns. The workflow includes image-based corner detection, calibration parameter estimation, validation of camera pose, and exploration of 3D position recovery from monocular images.

### 4. Optical Flow and Object Tracking

Implementation of computer vision techniques for motion analysis and object tracking using optical flow.

The project explores dense and sparse optical flow methods for motion estimation and compares their performance for object tracking. Additionally, background subtraction is combined with optical flow for improved tracking, and feature-based motion tracking is implemented using Shi-Tomasi corner detection and Kanade-Lucas-Tomasi (KLT) optical flow.

### 5. Image Registration and Stitching

Implementation of feature-based image alignment and panorama generation techniques in computer vision.

The project explores image registration using SIFT feature extraction, feature matching, homography estimation, and perspective transformation to align images from different viewpoints. Additionally, an image stitching pipeline is implemented using feature detection, RANSAC-based transformation estimation, and image blending to create panoramic views.

### 6. Feature Extraction and Image Classification

Implementation of computer vision methods for texture analysis, semantic segmentation, and biometric image classification.

The project explores feature extraction techniques including GLCM and LBP for image understanding tasks. The first part applies texture-based feature extraction and clustering methods for unsupervised semantic image segmentation. The second part uses LBP-based feature extraction combined with classification algorithms for fingerprint spoof detection.

### 7. Image Segmentation Techniques

Implementation of computer vision segmentation methods for extracting and separating regions of interest in images.

The project explores active contour models for object boundary detection and image segmentation, along with threshold-based segmentation techniques. The implementation includes contour-based segmentation using active contours and automatic threshold selection using Otsu's method for separating foreground and background regions.

### 8. Sudoku Solver Using Hough Transform

Implementation of a computer vision system for real-time Sudoku detection, recognition, and solving using image processing techniques.

The project applies edge detection and Hough transform methods to detect Sudoku grid structures from camera frames, extract individual cells, and recognize handwritten or printed digits using generalized Hough-based pattern matching. The detected puzzle is then solved and the solution is overlaid onto the original image.

### 9. Image Processing and Preprocessing Techniques

Implementation of fundamental image processing methods for color analysis, image quantization, enhancement, and background modeling.

The project explores various image processing techniques, including color space analysis for image-based measurement, K-means-based color quantization, histogram equalization for image enhancement, and background estimation through image averaging and threshold-based preprocessing.

### 10. Big Data Analytics with Apache Spark

Implementation of distributed data processing and analytics tasks using Apache Spark and PySpark.

The project covers multiple big data processing applications, including natural language processing on large text datasets, document similarity analysis, clustering using K-means++, and distributed matrix operations using MapReduce.

Key concepts:
- Apache Spark and PySpark
- Distributed data processing
- Natural language processing (NLP)
- Text analysis and similarity measurement
- K-means++ clustering
- MapReduce algorithms
- Performance analysis with different processing cores

### 11. Neural Cell Segmentation with Mask R-CNN

Changing the backbone of instance segmentation model for segmenting neural cells in microscopic images using Mask R-CNN.

The project evaluates and compares two backbone architectures, ResNet50 and CSPResNet50, within the Mask R-CNN framework for neural cell instance segmentation. The workflow includes dataset preparation, mask generation, data augmentation, model training, inference, and performance evaluation using segmentation metrics.

### 12. Hamshahri Newspaper Text Mining and Classification

Implementation of a natural language processing pipeline for analyzing and classifying Persian newspaper articles from the Hamshahri dataset.

The project covers the complete text mining workflow, including dataset processing, text preprocessing, feature extraction using TF-IDF, dimensionality reduction, unsupervised clustering, and supervised classification. Multiple machine learning models are evaluated and combined through an ensemble voting approach for document category prediction.

Key concepts:
- Natural language processing (NLP)
- Persian text preprocessing
- TF-IDF feature extraction
- Dimensionality reduction
- Unsupervised clustering
- Machine learning classification
- Ensemble learning
- Text classification

### 13. Traditional Face Recognition and Authentication

Implementation of a real-time face recognition system using classical computer vision and machine learning techniques.

The project develops a webcam-based authentication system that identifies authorized users without using deep learning models. The workflow includes collecting facial image data, extracting face features, training a traditional recognition model, and verifying user identity through similarity-based matching over consecutive webcam frames.

### 14. Peugeot 206 Price Prediction Using Web Scraping and Machine Learning

Implementation of an end-to-end machine learning pipeline for predicting Peugeot 206 Type 2 prices using real-world car advertisement data.

The project includes automated data collection through web scraping, feature extraction from vehicle advertisements, data preprocessing, machine learning model training, and price prediction. A prediction system is developed to estimate car prices and evaluate whether a seller's suggested price is reasonable based on learned market patterns.

### 15. Credit Card Fraud Detection Using SVM

Implementation of anomaly detection and fraud classification models for identifying fraudulent financial transactions using Support Vector Machines.

The project applies supervised SVM classification and One-Class SVM techniques to detect fraudulent transactions in an imbalanced credit card dataset. The workflow includes data preprocessing, model training, hyperparameter tuning, anomaly detection, and performance evaluation using appropriate classification metrics.

### 16. Forest Fire Classification Using Logistic Regression

Implementation of an image classification pipeline for detecting forest fire and non-fire scenes using machine learning.

The project processes forest images through resizing and normalization, extracts image features, and trains a Logistic Regression classifier for binary fire detection. The workflow includes dataset preparation, model training, probability threshold optimization, performance evaluation, and deployment of the trained model for real-time image prediction with visualized confidence scores.

### 17. MNIST Image Denoising using KNN

Implementation of an image denoising system for restoring corrupted handwritten digit images using machine learning techniques.

The project generates noisy training data from the MNIST dataset and develops a model to learn the mapping between noisy and clean digit images. The workflow includes noise generation, data preparation, model training, image reconstruction, and qualitative evaluation through visual comparison of noisy and denoised samples.

### 18. Persian Sentiment Analysis Using Naive Bayes

Implementation of a Persian text classification system for sentiment analysis of user reviews using a Naive Bayes classifier.

The project analyzes Snappfood user comments and classifies them into positive and negative sentiment categories. The workflow includes Persian text preprocessing, feature extraction, building a Naive Bayes model from scratch, training on labeled reviews, and evaluating classification performance on test data.

### 19. Decision Tree and Ensemble Learning Projects

Collection of machine learning projects focused on classification using decision trees, ensemble methods, and data preprocessing techniques.

The folder includes projects covering student performance prediction, Titanic survival analysis, and data science salary prediction. The implementations involve data preprocessing, feature engineering, decision tree modeling, hyperparameter tuning, pruning, visualization, and hybrid ensemble approaches.

### 20. KNN Classification and Data Preprocessing Projects

Collection of machine learning projects focused on classification using K-Nearest Neighbors (KNN) and data preprocessing techniques.

The folder includes handwritten digit recognition, Iris flower classification, and cancer risk prediction projects. The implementations cover data preprocessing, feature scaling, KNN model training, hyperparameter selection, cross-validation, and classification performance evaluation.

### 21. Regression and Machine Learning Applications

Collection of machine learning projects focused on regression modeling, data preprocessing, and predictive analytics.

The folder includes laptop price prediction, air quality prediction, and a domain-specific machine learning application using real-world datasets. The implementations cover data cleaning, feature engineering, visualization, feature scaling, regression model training, hyperparameter tuning, and model evaluation using regression metrics.

### 22. Malware Classification Using CNN

Implementation of a deep learning-based image classification system for detecting malware families using Convolutional Neural Networks.

The project converts malware bytecode and disassembly representations into grayscale images and trains a CNN model to classify samples into multiple malware categories. The workflow includes model design, hyperparameter tuning, learning rate optimization, regularization techniques, early stopping, dropout, batch normalization, and transfer learning using pretrained networks.

Key concepts:
- Convolutional Neural Networks (CNN)
- Malware image classification
- Deep learning optimization
- Hyperparameter tuning
- Regularization techniques
- Transfer learning
- Model evaluation

### 23. CMOS Amplifier Design and Simulation

Implementation and simulation of a single-stage CMOS amplifier design based on given analog circuit specifications.

The project focuses on transistor-level amplifier design in 90 nm CMOS technology, including analytical design, circuit simulation, and performance evaluation. The design is optimized to satisfy requirements such as DC gain, output voltage swing, CMRR, settling time, load driving capability, and low power consumption.

### 24. FPGA-Based Image Processing Filters

Implementation of hardware image processing filters using FPGA and VHDL for real-time image enhancement and edge detection.

The project designs and evaluates FPGA-based 3×3 image filters, including an average filter for image smoothing and an edge detection filter using the Laplacian operator. The workflow includes MATLAB-based image processing analysis, VHDL hardware implementation, testbench simulation, and comparison between software and FPGA outputs.

Key concepts:
- FPGA image processing
- VHDL hardware design
- Digital filters
- Average smoothing filter
- Edge detection filter
- Laplacian operator
- Hardware simulation and verification

### 25. EEG Signal Feature Extraction and Classification

Analysis and classification of EEG biomedical signals using MATLAB, signal preprocessing, feature extraction, KNN classification, and K-means clustering.

This project focuses on processing EEG signals from two classes (A and B), extracting statistical and frequency-domain features, and evaluating their ability to separate different mental states.

### 26. Digital Image Processing: Enhancement, Filtering, Segmentation, and Registration

Implementation of digital image processing algorithms using Python and computer vision techniques for image analysis and enhancement.

This project covers fundamental and advanced image processing tasks, including image transformations, histogram analysis, spatial and frequency-domain filtering, image restoration, segmentation, and image registration.

Main components:
- Image reading and analysis
- Histogram computation and matching
- Bit-plane slicing
- Intensity transformations
- Spatial filtering and noise reduction
- Frequency-domain processing using Fourier Transform
- Image restoration techniques
- Morphological image processing
- Image segmentation using Split and Merge
- Feature-based image registration
- Motion and object detection
- OpenCV-based image processing

### 27. FPGA-Based Simple CPU Design Using VHDL

Implementation and simulation of a simple CPU architecture using VHDL with custom registers, memory, control logic, and instruction execution.

This project focuses on designing a basic processor consisting of essential CPU components such as Accumulator (ACC), Memory Address Register (MAR), Memory Data Register (MDR), Program Counter (PC), and a control unit. The system implements instruction decoding, memory communication, and sequential execution using a finite state machine.

Main components:
- FPGA-based CPU design
- VHDL hardware description
- Register-level architecture
- Accumulator (ACC) implementation
- Memory Address Register (MAR)
- Memory Data Register (MDR)
- Program Counter (PC)
- Control unit and FSM design
- Instruction decoding and execution
- Memory interface design
- VHDL simulation and testbench verification

### 28. FPGA Arithmetic Circuits and Signal Processing Modules

Implementation and simulation of arithmetic and timing-based digital circuits using VHDL for FPGA platforms.

This project includes the design of an accumulator-based numerical integration circuit and a configurable clock frequency divider. The implementations focus on sequential circuit design, arithmetic operations, clock management, and verification through VHDL testbenches.

Main components:
- FPGA-based sequential circuit design
- Accumulator architecture
- Numerical integration using discrete approximation
- Arithmetic modules (adder/subtractor)
- Divider circuits
- Clock frequency division
- Generic parameterized VHDL design
- Reset and control signal handling
- Simulation and testbench verification

