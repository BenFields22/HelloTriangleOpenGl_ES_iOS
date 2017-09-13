//
//  ViewController.m
//  HelloGl
//
//  Created by Benjamin G Fields on 9/13/17.
//  Copyright © 2017 Benjamin G Fields. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    GLuint VBO;
    GLuint program;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView*)self.view;
    view.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    [self setupvertexBuffer];
    [self setupShader];
}

-(void)setupvertexBuffer{
    GLfloat vertices[] ={
        -1,-1,0,
        0,0,0,
        1,-1,0
    };
    
    glGenBuffers(1, &VBO);
    glBindBuffer( GL_ARRAY_BUFFER, VBO );
    glBufferData( GL_ARRAY_BUFFER, sizeof( vertices ), vertices, GL_STATIC_DRAW );
    
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3*sizeof(GLfloat), (GLvoid*)0);
    glDisableVertexAttribArray(0);

    
}

-(void)setupShader{
    const GLchar* vertexSource = "attribute vec4 a_Position;\n"
    "void main(void){\n"
    "gl_Position = a_Position;\n}\0";
    
    
    const GLchar* fragSource = "void main(void){gl_FragColor = vec4(1.0,.5,1,1);}\0";
    
    GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexSource, NULL);
    glCompileShader(vertexShader);
    
    
    GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragSource, NULL);
    glCompileShader(fragmentShader);
    
    
    program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    
    
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.0f,1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(0);
    glUseProgram(program);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    glDisableVertexAttribArray(0);
    
}

@end
