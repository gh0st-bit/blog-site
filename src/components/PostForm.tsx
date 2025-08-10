
'use client';

import { useState, useEffect } from 'react';

type Post = {
  _id?: string;
  title: string;
  content: string;
};

export default function PostForm({ post, onSave, onCancel }: Readonly<{ 
  post?: Post; 
  onSave: () => void;
  onCancel?: () => void;
}>) {
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
    if (onCancel) {
      onCancel();
    } else {
      onSave(); // Fallback to onSave if onCancel not provided
    }
  };

  const getSubmitButtonText = () => {
    if (isSubmitting) return 'Publishing...';
    return post ? 'Update Post' : '📝 Publish Post';
  };

  return (
    <div className="bg-white rounded-lg shadow-lg border border-gray-200 overflow-hidden">
      <div className="bg-gradient-to-r from-blue-600 to-purple-600 px-6 py-4">
        <h2 className="text-xl font-semibold text-white">
          {post ? '✏️ Edit Post' : '✍️ Create New Post'}
        </h2>
      </div>
      
      <form onSubmit={handleSubmit} className="p-6 space-y-6">
        <div>
          <label htmlFor="title" className="block text-sm font-medium text-gray-700 mb-2">
            Post Title
          </label>
          <input
            id="title"
            className="w-full p-4 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-500"
            placeholder="Enter an engaging title for your post..."
            value={title}
            onChange={e => setTitle(e.target.value)}
            required
            disabled={isSubmitting}
          />
        </div>
        
        <div>
          <label htmlFor="content" className="block text-sm font-medium text-gray-700 mb-2">
            Post Content
          </label>
          <textarea
            id="content"
            className="w-full p-4 border border-gray-300 rounded-lg h-40 resize-vertical focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-500"
            placeholder="Write your blog post content here. Share your thoughts, experiences, and insights..."
            value={content}
            onChange={e => setContent(e.target.value)}
            required
            disabled={isSubmitting}
          />
        </div>
        
        <div className="flex gap-3 pt-4">
          <button 
            className="flex-1 bg-gradient-to-r from-green-500 to-green-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-green-600 hover:to-green-700 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed shadow-md"
            type="submit"
            disabled={isSubmitting}
          >
            {getSubmitButtonText()}
          </button>
          
          <button 
            type="button"
            className="px-6 py-3 bg-gray-500 text-white font-semibold rounded-lg hover:bg-gray-600 transition-colors duration-200 disabled:opacity-50"
            onClick={handleCancel}
            disabled={isSubmitting}
          >
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
}
