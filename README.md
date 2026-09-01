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

