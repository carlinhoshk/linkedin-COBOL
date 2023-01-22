import numpy as np
from PIL import Image

def merge_images(images, output_path):
    # Open first image
    img = Image.open(images[0])
    width, height = img.size
    
    # Create a blank image with the same size as the first image
    output = Image.new('RGB', (width, height))
    
    # Coordinates for pasting the images
    x = 0
    y = 0
    
    # Iterate over the rest of the images
    for i in range(1, len(images)):
        img = Image.open(images[i])
        img_width, img_height = img.size
        if img_width != width or img_height != height:
            # Resize the image to match the size of the first image
            img = img.resize((width, height))
        
        # Paste the image onto the blank image
        output.paste(img, (x, y))
        
        # Update the coordinates for pasting the next image
        x += img_width
        if x + img_width > width:
            x = 0
            y += img_height
    
    # Save the output image
    output.save(output_path)

# Example usage
images = ['11.png', '12.png', '13.png', '14.png', '15.png', '16.png', '17.png', '18.png']
merge_images(images, 'output.jpg')
