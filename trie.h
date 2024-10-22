#include<iostream>
#include<unordered_map>
#include<vector>
#include<algorithm>
#include<string>
using namespace std;

class Trie;

class Node
{
    char ch;
    bool isTerminal;
    unordered_map<char,Node*> m;

 public:
    Node(char d)
    {
       this->ch=d;
       isTerminal=false;
    }   

    friend class Trie;
};

class Trie
{
     Node* root;

public:

   Trie()
   {
    root= new Node('\0');
   }


   void insert(string key)
   {
       Node* temp=root;
       for (auto ch : key)
       {
         if (temp->m.count(ch)==0)
         {
            Node* n=new Node(ch);
            temp->m[ch]=n;
         }
          temp=temp->m[ch];
       }
      temp->isTerminal=true;
   }


   bool search(string key)
   {
        Node* temp=root;
        for (auto ch : key)
        {
          
          
          if (temp->m.count(ch)==0)
               {
                  return NULL;
               }
 
            temp=temp->m[ch];
        }
        return temp->isTerminal;
   }

  bool isprefix(string prefix)
  {
   Node* t=root;
   for (auto x: prefix)
   {
      if (t->m.count(x)==0)
         {
                  return false;
         }
       t=t->m[x];
   }

   if (t!=NULL)
   {
      return true;
   }
   else
   {
      return false;
   }
  }
    
};

