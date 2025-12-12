// src/hooks/usePagination.js
import { useState, useMemo, useCallback } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';

/**
 * Custom hook for pagination with URL query parameters
 * @param {number} totalItems - Total number of items
 * @param {number} defaultPageSize - Default items per page
 * @returns {object} Pagination state and functions
 */
function usePagination(totalItems = 0, defaultPageSize = 10) {
  const navigate = useNavigate();
  const location = useLocation();

  // Parse query params from URL
  const queryParams = useMemo(() => {
    const params = new URLSearchParams(location.search);
    return {
      page: parseInt(params.get('page')) || 1,
      pageSize: parseInt(params.get('pageSize')) || defaultPageSize,
    };
  }, [location.search, defaultPageSize]);

  const [currentPage, setCurrentPage] = useState(queryParams.page);
  const [pageSize, setPageSize] = useState(queryParams.pageSize);

  // Calculate total pages
  const totalPages = useMemo(() => {
    return Math.ceil(totalItems / pageSize) || 1;
  }, [totalItems, pageSize]);

  // Calculate current range
  const currentRange = useMemo(() => {
    const start = (currentPage - 1) * pageSize + 1;
    const end = Math.min(currentPage * pageSize, totalItems);
    return { start, end };
  }, [currentPage, pageSize, totalItems]);

  // Update URL with pagination params
  const updateURL = useCallback((page, size) => {
    const params = new URLSearchParams(location.search);
    params.set('page', page.toString());
    params.set('pageSize', size.toString());
    navigate(`${location.pathname}?${params.toString()}`, { replace: true });
  }, [navigate, location.pathname, location.search]);

  // Go to specific page
  const goToPage = useCallback((page) => {
    const validPage = Math.max(1, Math.min(page, totalPages));
    setCurrentPage(validPage);
    updateURL(validPage, pageSize);
  }, [totalPages, pageSize, updateURL]);

  // Go to next page
  const nextPage = useCallback(() => {
    if (currentPage < totalPages) {
      goToPage(currentPage + 1);
    }
  }, [currentPage, totalPages, goToPage]);

  // Go to previous page
  const prevPage = useCallback(() => {
    if (currentPage > 1) {
      goToPage(currentPage - 1);
    }
  }, [currentPage, goToPage]);

  // Change page size
  const changePageSize = useCallback((size) => {
    setPageSize(size);
    setCurrentPage(1);
    updateURL(1, size);
  }, [updateURL]);

  // Get paginated items from array
  const paginateItems = useCallback((items) => {
    const startIndex = (currentPage - 1) * pageSize;
    const endIndex = startIndex + pageSize;
    return items.slice(startIndex, endIndex);
  }, [currentPage, pageSize]);

  return {
    currentPage,
    pageSize,
    totalPages,
    totalItems,
    currentRange,
    goToPage,
    nextPage,
    prevPage,
    changePageSize,
    paginateItems,
    hasNextPage: currentPage < totalPages,
    hasPrevPage: currentPage > 1,
  };
}

export default usePagination;
