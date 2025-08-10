
'use client';

import { useState, useEffect } from 'react';

type Post = {
  _id?: string;
  title: string;
  content: string;
};

export default function PostForm({ post, onSave }: Readonly<{ post?: Post; onSave: () => void }>) {
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    setTitle(post?.title || '');
    setContent(post?.content || '');
  }, [post]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    try {
      const method = post ? 'PUT' : 'POST';
      const url = post ? `/api/posts/${post._id}` : '/api/posts';
      
      const response = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title, content }),
      });
      
      if (response.ok) {
        setTitle('');
        setContent('');
        onSave();
      } else {
        console.error('Failed to save post');
      }
    } catch (error) {
      console.error('Error saving post:', error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleCancel = () => {
    setTitle('');
    setContent('');
    onSave(); // This will clear the editing post
  };

  const getSubmitButtonText = () => {
    if (isSubmitting) return 'Saving...';
    return post ? 'Update Post' : 'Create Post';
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 p-6 border rounded-lg shadow-sm bg-white">
      <h2 className="text-xl font-semibold">
        {post ? 'Edit Post' : 'Create New Post'}
      </h2>
      
      <input
        className="w-full p-3 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
        placeholder="Post title..."
        value={title}
        onChange={e => setTitle(e.target.value)}
        required
        disabled={isSubmitting}
      />
      
      <textarea
        className="w-full p-3 border rounded-md h-32 resize-vertical focus:outline-none focus:ring-2 focus:ring-blue-500"
        placeholder="Write your post content here..."
        value={content}
        onChange={e => setContent(e.target.value)}
        required
        disabled={isSubmitting}
      />
      
      <div className="flex gap-2">
        <button 
          className="px-6 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 transition-colors disabled:opacity-50"
          type="submit"
          disabled={isSubmitting}
        >
          {getSubmitButtonText()}
        </button>
        
        {post && (
          <button 
            type="button"
            className="px-6 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600 transition-colors"
            onClick={handleCancel}
            disabled={isSubmitting}
          >
            Cancel
          </button>
        )}
      </div>
    </form>
  );
}
