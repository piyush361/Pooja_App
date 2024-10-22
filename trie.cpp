#include<iostream>
#include<vector>
#include<string>
#include"trie.h"
using namespace std;

int main()
{
    Trie t;
    t.insert("apple");
    t.insert("appy");
    t.insert("apl");
    t.insert("piyush");
   
    cout<<t.isprefix("piyu")<<" ";
    return 0;
}