import cv2 as cv
import numpy as np
import pickle
import glob

# Loading the saved model
with open('log_reg_1.pkl', 'rb') as f:
    model = pickle.load(f)

# Setting the common size of the images
SIZE = (224, 224)
# Looping over the images and predict their labels
#for image_path in glob.glob(f'sample_forest_images/*.png'):
for i, image_path in enumerate(glob.glob('sample_forest_images/*.png')):
    image = cv.imread(image_path, cv.IMREAD_COLOR)
    image = cv.resize(image, SIZE)

    image = cv.normalize(image, None, alpha=0, beta=1, norm_type=cv.NORM_MINMAX, dtype=cv.CV_32F)

    proba = model.predict_proba(np.expand_dims(image, axis=0).reshape(1, -1))[0, 1]
    #print(proba)
    proba_percent = proba * 100
    label = 'fire' if proba < 0.5 else 'no-fire'
    if label=='fire':
        proba_percent=100-proba_percent 

    # Show the label and probability on the image
    color = (0, 0, 255) if label == 'fire' else (0, 255, 0)
    text = f'{label} ({proba_percent:.2f}%)'
    #cv.putText(image, text, (10, 30), cv.FONT_HERSHEY_SIMPLEX, 1, color, 2)
    font_scale = 0.5
    thickness = 1
    color = (0, 0, 255) if label == 'fire' else (0, 255, 0)
    text_size, _ = cv.getTextSize(text, cv.FONT_HERSHEY_SIMPLEX, font_scale, thickness)
    text_x = 10
    text_y = text_size[1] + 10
    cv.putText(image, text, (text_x, text_y), cv.FONT_HERSHEY_SIMPLEX, font_scale, color, thickness)
    resized_image = cv.resize(image, (900, 900))
    cv.imshow(f'Image {i+1}', resized_image)
    cv.waitKey(0)

cv.destroyAllWindows()