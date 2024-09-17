#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dictionary.h"

dictionary_t *create_dictionary() {
    dictionary_t *dict = malloc(sizeof(dictionary_t));
    if (dict == NULL) {
        return NULL;
    }
    dict->root = NULL;
    dict->size = 0;
    return dict;
}

int insert_helper(node_t *root, const char *word){
    if(strcmp(word, root->word) < 0){
        if(root->left == NULL){
            root->left = malloc(sizeof(node_t));
            if(root->left == NULL){
                return -1;
            }
            strcpy(root->left->word, word);
            root->left->left = NULL;
            root->left->right = NULL;
        }
        else {
            return insert_helper(root->left, word);
        }
    }
    else{
        if(strcmp(word, root->word) > 0){
            if(root->right == NULL){
                root->right = malloc(sizeof(node_t));
                if(root->right == NULL){
                    return -1;
                }
                strcpy(root->right->word, word);
                root->right->right = NULL;
                root->right->left = NULL;
            }
            else {
                return insert_helper(root->right, word);
            }
        }
    }

    return 0;
}

int dict_insert(dictionary_t *dict, const char *word) {
    if(dict == NULL || word == NULL){
        return -1;
    }

    if(dict->root == NULL){
        dict->root = malloc(sizeof(node_t));
        if(dict->root == NULL){
            return -1;
        }
        strcpy(dict->root->word, word);
        dict->root->left = NULL;
        dict->root->right = NULL;
        dict->size++;
        return 0;
    }
    else {
         return insert_helper(dict->root, word);
    }
}

int find_helper(node_t *root, const char *query){
    if(root == NULL){
        return 0;
    }
    if(strcmp(query, root->word) == 0){
        return 1;
    }
    if(strcmp(query, root->word) < 0){
        return find_helper(root->left, query);
    }
    else if(strcmp(query, root->word) > 0) {
        return find_helper(root->right, query);
    }
    
    return 0;
}

int dict_find(const dictionary_t *dict, const char *query) {
    if(dict == NULL || query == NULL) 
        return 0;

    return find_helper(dict->root, query);
}

void print_helper(node_t *root){
    // inorder traversal

    if(root->left != NULL){
        print_helper(root->left);
    }
    
    printf("%s\n", root->word);

    if(root->right != NULL)
        print_helper(root->right);
}

void dict_print(const dictionary_t *dict) {
    if(dict == NULL || dict->root == NULL) {
        return; 
    }

    print_helper(dict->root);
}

void free_helper(node_t *root){
    // postorder travesal
    if(root == NULL){
        return;
    }
    free_helper(root->left);
    free_helper(root->right);
    free(root);
}

void dict_free(dictionary_t *dict) {
    free_helper(dict->root);
    free(dict);
}

dictionary_t *read_dict_from_text_file(const char *file_name) {
    FILE *f = fopen(file_name, "r");
    if(f == NULL){
        return NULL;
    }

    dictionary_t *new_dict = create_dictionary();
    char word[MAX_WORD_LEN];

    while(fscanf(f, "%s", word) == 1){
      dict_insert(new_dict, word);  
    }
    
    fclose(f);
    return new_dict;
}

void write_helper(node_t *root, FILE *f){
    if(root == NULL) 
        return;
    fprintf(f, "%s\n", root->word);
    write_helper(root->left, f);
    write_helper(root->right, f);
}

int write_dict_to_text_file(const dictionary_t *dict, const char *file_name) {
    FILE *f = fopen(file_name, "w");
    if(dict == NULL || f == NULL) 
        return -1;
        
    write_helper(dict->root, f);
    
    fclose(f);
    return 0;
}