//
//  SGLView.m
//  SimpleOpenGLInit
//
//  Created by Valentin Radu on 13/01/2013.
//  Copyright (c) 2013 Valentin Radu. All rights reserved.
//

#import "SGLView.h"

@implementation SGLView{
    GLKBaseEffect * effect;
    GLuint vertexArray;
    GLuint vertexBuffer;
    GLuint indexBuffer;
}


static const GLbyte kVertexNum = 4;
static const GLbyte kIndexNum = 6;


//the vertex data is added from the left bottom corner
//towards right, up and finally left
//as the ascii art suggests
static const GLKVector3 vertexData[kVertexNum] =
{
    {-0.5f, -0.5f, 0.0f},//0  3-----2
    {0.5f, -0.5f, 0.0f},//1   |     |
    {0.5f, 0.5f, 0.0f},//2    |     |
    {-0.5f, 0.5f, 0.0f},//3   0-----1
};


//we basically draw 2 triangles
//as described in the ascii art
static const GLbyte indexData[kIndexNum] =
{
    0, 3, 1,
    3, 2, 1
    
    /*
    
    3--2
    |\ |
    | \|
    0--1
    
    */
};


- (id)initWithFrame:(CGRect)frame context:(EAGLContext *)context
{
    self = [super initWithFrame:frame context:context];
    if (self) {
        
        
        //the effect makes our life easier
        //we need not worry about the colour array nor the projection
        effect = [[GLKBaseEffect alloc] init];
        effect.useConstantColor = GL_TRUE;
        
        //nor for the projection
        //which will be orthogonal for the sake of simplicity
        //the parameters are for 4-inch retina, 3.5 retina would have been
        //-1.0f, 1.0f, -1.5f, 1.5f, 1.0f, -1.0f 
        GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(-1.0f, 1.0f, -1.7f, 1.7f, 1.0f, -1.0f);
        effect.transform.projectionMatrix = projectionMatrix;
        //set a color for our drawing
        effect.constantColor = GLKVector4Make(190.0f/255.0f, 182.0f/255.0f, 171.0f/255.0f, 1.0f);

        
        
        
        //generate and bind each of the vertex and index buffer
        //upload data to them
        glGenVertexArraysOES(1, &vertexArray);
        glBindVertexArrayOES(vertexArray);
        
        glGenBuffers(1, &vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER,
                     kVertexNum*sizeof(GLKVector3),
                     &vertexData,
                     GL_STATIC_DRAW);
        
        glGenBuffers(1, &indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER,
                     kIndexNum*sizeof(GLbyte),
                     &indexData,
                     GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition,
                              3,
                              GL_FLOAT,
                              GL_FALSE,
                              sizeof(GLKVector3),
                              (void*)0);
        
        glBindVertexArrayOES(0);
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    [effect prepareToDraw];
    
    //clear the screen
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    glBindVertexArrayOES(vertexArray);
    glDrawElements(GL_TRIANGLE_STRIP, kIndexNum, GL_UNSIGNED_BYTE, (void*)0);
<<<<<<< HEAD
    
=======
>>>>>>> Sample uses vertex arrays
    glBindVertexArrayOES(0);
}

-(void)dealloc
{
    glDeleteBuffers(1, &indexBuffer);
    glDeleteBuffers(1, &vertexBuffer);
    glDeleteVertexArraysOES(1, &vertexArray);
    
    effect = nil;
}

@end
