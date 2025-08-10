
'use client';

import PostList from "@/components/PostList";
import PostForm from "@/components/PostForm";
import { useState } from "react";

type Post = {
  _id?: string;
  title: string;
  content: string;
};

export default function Home() {
  const [editingPost, setEditingPost] = useState<Post | null>(null);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [refresh, setRefresh] = useState(false);

  const handleEdit = (post: Post) => {
    setEditingPost(post);
    setShowCreateForm(true);
  };
  
  const handleSave = () => {
    setEditingPost(null);
    setShowCreateForm(false);
    setRefresh(r => !r);
  };

  const handleCreateNew = () => {
    setEditingPost(null);
    setShowCreateForm(true);
  };

  const handleCancel = () => {
    setEditingPost(null);
    setShowCreateForm(false);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto py-8 px-4">
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">My Blog Site</h1>
          <p className="text-gray-600">Share your thoughts with the world</p>
        </div>

        <div className="mb-6">
          {!showCreateForm ? (
            <button 
              onClick={handleCreateNew}
              className="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition-colors duration-200"
            >
              ✍️ Create New Post
            </button>
          ) : (
            <PostForm 
              post={editingPost ?? undefined} 
              onSave={handleSave}
              onCancel={handleCancel}
            />
          )}
        </div>

        <div className="space-y-6">
          <h2 className="text-2xl font-semibold text-gray-800 border-b-2 border-gray-200 pb-2">
            Published Posts
          </h2>
          <PostList 
            key={refresh ? 'refresh' : 'no-refresh'} 
            onEdit={handleEdit}
          />
        </div>
      </div>
    </div>
  );
}
